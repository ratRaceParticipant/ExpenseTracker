//
//  CoreDataViewModel.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 09/09/23.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    @Published var transactionData: [TransactionEntity] = []
    @Published var categoryData: [TransactionCategoryEntity] = []
    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Occured in establishing connection: \(error)")
            } else {
                print("Connection to core data successfull")
            }
        }
        fetchTransactionData()
        fetchCategoryData()
    }
    func fetchTransactionData() {
        let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        let sort = NSSortDescriptor(keyPath: \TransactionEntity.createdOn, ascending: false)
        
        request.sortDescriptors = [sort]
        do {
            transactionData = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching Transaction Data: \(error)")
        }
    }
    func addTransaction(transactionName: String, transactionAmount: Int64, transactionDate: Date ,category: TransactionCategoryEntity, isIncome: Bool) {
        let newTransaction = TransactionEntity(context: container.viewContext)
       
        newTransaction.transactionDate = transactionDate
        newTransaction.name = transactionName
        newTransaction.amount = transactionAmount
        newTransaction.createdOn = Date()
        newTransaction.category = category
        newTransaction.isIncome = category.isIncome
        saveData()
    }
    
    
    func fetchCategoryData() {
        let request = NSFetchRequest<TransactionCategoryEntity>(entityName: "TransactionCategoryEntity")
        let sort = NSSortDescriptor(keyPath: \TransactionCategoryEntity.createdOn, ascending: false)
        request.sortDescriptors = [sort]
        request.returnsDistinctResults = true
        do {
            categoryData = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching Transaction Data: \(error)")
        }
    }
    
    func addCategory(categoryName: String, isIncome: Bool) {
        let newCategory = TransactionCategoryEntity(context: container.viewContext)
        newCategory.isIncome = isIncome
        newCategory.name = categoryName
        newCategory.createdOn = Date()
        saveData()
    }
    
    func deleteTransaction(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        container.viewContext.delete(transactionData[index])
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchTransactionData()
            fetchCategoryData()
        } catch let error {
            print("Error Saving Data: \(error)")
        }
    }
    
    func getAmountByCategory(category: TransactionCategoryEntity) -> Int {
        let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        let filter = NSPredicate(format: "category == %@", category)
        request.propertiesToFetch = ["amount"]
        request.predicate = filter
        do {
            
            let data = try container.viewContext.fetch(request)
            var sum: Int = 0
            
            for item in data {
                sum += Int(item.amount)
            }
            return sum
            
        } catch let error {
            print("Error Fetching Transaction Amount By Category: \(error)")
        }
        return 0
    }
    
    
    func getIncomeOrExpenses(isIncome: Bool) -> Int{
        let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        
        let filter = NSPredicate(format: "isIncome == %i", isIncome ? 1 : 0)
        request.propertiesToFetch = ["amount"]
        request.predicate = filter
        do {
            
            let data = try container.viewContext.fetch(request)
            var sum: Int = 0
            
            for item in data {
                sum += Int(item.amount)
            }
            return sum
            
        } catch let error {
            print("Error Fetching Transaction Amount By Income or Expense: \(error)")
        }
        return 0
    }
    
    
    func getProfit() -> Int {
        return getIncomeOrExpenses(isIncome: true) - getIncomeOrExpenses(isIncome: false)
    }
    
    
    func getDataAccordingToBatchSize(fetchLimit: Int = 0) -> [TransactionEntity]{
        var data: [TransactionEntity] = []
        let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        let sort = NSSortDescriptor(keyPath: \TransactionEntity.createdOn, ascending: false)
        request.fetchLimit = fetchLimit
        request.sortDescriptors = [sort]
        do {
            data = try container.viewContext.fetch(request)
            
        } catch let error {
            print("Error Fetching Transaction Data: \(error)")
        }
        return data
    }
    
    func isCategoryNameUnique(name: String) -> Bool{
          for data in categoryData {
              if data.name?.uppercased() == name.uppercased() {
                return false
            }
        }
        return true
    }
}
