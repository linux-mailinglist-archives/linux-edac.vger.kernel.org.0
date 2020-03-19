Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F5B18C120
	for <lists+linux-edac@lfdr.de>; Thu, 19 Mar 2020 21:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgCSUPD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Mar 2020 16:15:03 -0400
Received: from mail-eopbgr750082.outbound.protection.outlook.com ([40.107.75.82]:50662
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbgCSUPC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Mar 2020 16:15:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bApFadA4K+O1nYXmaOgtBPSpL/2C5imb0680ZUYasxNY7t90jBmZ3wx5RDgPV38yRzn1eLlR1GbLn9BZ1HojY+uFM/rHh/nuKkiSkfqTKWkWPvstTWdIwretuLilnMJi5RvnZ+U52pTHLEpHtHrLhRm5MQ53edeM2ooMbMiYFr9H3rP4983PvSZP/220bGvaR3nle2X5MkHYnK37hMm7fxZZ7c8NCLk0omUYeQxFL5JtrZH57v2BtDClZxV/CAMrREPBTddersq6n4dzXdLPSxfMF1Qx1olkS/2957N4SFhf7Ld4mlDSPAm8MUR+IC6nSol0hmnf/Fr4zjI4XqyvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLxVfpS+rLvwjMMGVBVkoUjWGPdPfGSKHqHMDwMdPXk=;
 b=Xv4FCkQiystrUoICtVS/iTct99Zlbp/uqkud10Pd3f1OXf2cwxqplP+iQ2psyf993GvJONKFhHL1k0v/GnzcZ5EcbcX95/9fhy+SyhTp8JcuTBLoiEMPUKztr76Q4ZZ0ybcUNmsk7GfPDjSXQi0+PUz89W83v0U+SHZizvrbHivC81XFTYOR3ESVq0laOSQ/5nWV77ti0NdOwdTftEymlKutAUl6FKAw6j8UyJVFoxJgtkfzGuGSzw42tfr91sS63L+33JliYsXxjp7YYzfutcRrv/yFdmTMfySSIy8eWaWHNJDaMXz5Mpyh112LdvHCcWfdRZ/jRH+mrSPBD9LMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLxVfpS+rLvwjMMGVBVkoUjWGPdPfGSKHqHMDwMdPXk=;
 b=p7O4f91gkCJGrtwY65CJiSlLTQ7Eldn79qNbwDGNORhNFMpkpF6+9ZV1s0apW2k/oz77EO9YQq1gPMVtMddOud0vbxfsGMbu1P7vH7lbDHZQ7J/GPTH9BL7p7oREBzkUWb0oP5tATTWZIu7TdMY2qutsd4+QSpGQKQLlEF68b/Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wei.Huang2@amd.com; 
Received: from CY4PR12MB1352.namprd12.prod.outlook.com (2603:10b6:903:3a::13)
 by CY4PR12MB1719.namprd12.prod.outlook.com (2603:10b6:903:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Thu, 19 Mar
 2020 20:14:57 +0000
Received: from CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::5cdb:285d:f962:c2a8]) by CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::5cdb:285d:f962:c2a8%12]) with mapi id 15.20.2814.021; Thu, 19 Mar
 2020 20:14:57 +0000
Subject: Re: [PATCH 1/1] x86/mce/amd: Add PPIN support for AMD MCE
To:     Borislav Petkov <bp@alien8.de>, Wei Huang <wei.huang2@amd.com>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        yazen.ghannam@amd.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-edac@vger.kernel.org, x86@kernel.org,
        smita.koralahallichannabasappa@amd.com
References: <20200311044409.2717587-1-wei.huang2@amd.com>
 <20200316180829.GP26126@zn.tnic>
From:   Wei Huang <whuang2@amd.com>
Message-ID: <53d25b8c-dabe-1b91-4d3b-0a223075e42a@amd.com>
Date:   Thu, 19 Mar 2020 15:14:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200316180829.GP26126@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:208:134::16) To CY4PR12MB1352.namprd12.prod.outlook.com
 (2603:10b6:903:3a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.15] (24.55.15.93) by MN2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:208:134::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 20:14:55 +0000
X-Originating-IP: [24.55.15.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 883cc8d5-3d2c-48e5-4ee1-08d7cc4231c7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1719:|CY4PR12MB1719:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB17195A454CFAECCCE8F809BBCFF40@CY4PR12MB1719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(199004)(5660300002)(110136005)(16576012)(31686004)(16526019)(53546011)(2906002)(4326008)(52116002)(316002)(186003)(26005)(478600001)(36756003)(31696002)(6636002)(66476007)(8936002)(8676002)(66556008)(956004)(81156014)(6486002)(2616005)(66946007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1719;H:CY4PR12MB1352.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NenC2u/GUkVIQpWyq4v9pYWWOT0B9OSdpVkWcy+ll0jx3CQ2+8nHRzaLWD2cfuMzY9be63usgWSxLhka80bRUYaeFMxarcZNFTGWX/d0SoUrGm7FHa90SK8LIk5a7t6zKPoASr0nEHUVGCc53LCy4sZVrzLBqO6whjKg5Ws4rklsitQh8A1fwKn6rDn0WHCmN9n0Rpda++Mxjb67sd65N2PZ95VaxoPn4Ad/n8NiIkdUT9KRRJ4oYQvxghW7rzyTFHVGcT/k7FSbjNZd4Uk6E9gZuAgUERlL46RyNeROJL7qOvNRcq1BwETHZUGw2zFijdLwWE1m3aLS6xDCMyCuOWkAFeTIHBJ4FlrpEMpkoNKt1BA8p+DNXdIuhRi6PAAfl00SNXlYsUJOu8pzrZGw5PkrCO7tLB64Fh9UHg0c7XP3frpKST1L4lBnDIhWo+E
X-MS-Exchange-AntiSpam-MessageData: RygNXeh/LYauDDKHHT3DmxLV+9D0n7561ldT4ulQ6KCIdgK78hIRJQY4VVb5d9OT7Q3+pyzwBEHGse9MHZMzNHeMBTzxE0b262jgs/90D0Ix7RQ0IooJ31YNKrlVy9wGyDamlRNT/5f5ZiNSTBVhrg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883cc8d5-3d2c-48e5-4ee1-08d7cc4231c7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 20:14:57.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBtPqVswOtiw+t+e5wD1h7sUu0xrREWhg9a0vIUGM++oO3UgaqyvqGo+14KqZCqO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1719
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 3/16/20 1:08 PM, Borislav Petkov wrote:
> On Tue, Mar 10, 2020 at 11:44:09PM -0500, Wei Huang wrote:
>> Newer AMD CPUs support the feature of protected processor identification
>> number (PPIN). This patch detects and enables PPIN support on AMD platforms
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.
> 
>> and includes PPIN info in MCE records if available. Because this feature is
>> almost identical on both Intel and AMD, it re-uses X86_FEATURE_INTEL_PPIN
>> feature bit and renames it to X86_FEATURE_PPIN.
> 
> Strictly speaking, you can't rename it anymore because it is visible in
> /proc/cpuinfo and thus ABI.
> 
> Besides, we have already a cpufeatures.h leaf for exactly that word:
> 
> /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
> 
> which means you can call the AMD define
> 
> #define X86_FEATURE_AMD_PPIN               ( 13*32+23) /* AMD Protected Processor Inventory Number */
> 
> and /proc/cpuinfo will have "amd_ppin" and the code will use the
> respective vendor flag to test.

BTW Intel PPIN doesn't have a respective CPUID feature bit. So it relies
on intel_ppin_init() to turn it on. After that, mce_setup() can use
this_cpu_has(X86_FEATURE_INTEL_PPIN) to read MSR_PPIN. This is fine.

In contrast, AMD has 0x80000008_EBX[23] defined for PPIN feature. When
this CPUID bit is set, X86_FEATURE_AMD_PPIN is ON. But there are cases
where MSR_AMD_PPIN_CTL is locked. Under such circumstance I think
X86_FEATURE_AMD_PPIN should be cleared.

My proposal is to move mce_amd_ppin_init() function to
./arch/x86/kernel/cpu/amd.c and probe X86_FEATURE_AMD_PPIN there. This
is similar to what early_detect_mem_encrypt() does. Later, mce_setup()
can use X86_FEATURE_AMD_PPIN directly. Is this approach acceptable?

> 
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Smita Koralahalli Channabasappa <smita.koralahallichannabasappa@amd.com>
> 
> What does this SOB mean? Grep Documentation/ for "Co-developed-by" in
> case this is what you're trying to express.
> 
