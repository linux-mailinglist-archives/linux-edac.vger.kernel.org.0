Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C07F44AC9B
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 12:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhKILdH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 06:33:07 -0500
Received: from mail-bn8nam08on2081.outbound.protection.outlook.com ([40.107.100.81]:23393
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234461AbhKILdH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Nov 2021 06:33:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Emx4B/HwaWKn9bKbRVNe30cQJ55uqLsrk4uba7g8o3VyqUaO6OSnU6XMdK1rP43uTaIulV/8jeVluBHbnf9wEfUeIZ4y3OmgKwiJWJEo8Ks5tJeXcw5f3M7toGbRz3KEsDNcLZo3RYtPC8LcAPFD3NFKaurzGSse7lWfzhpqfz7JzkFkds/y/14CCE/S4tXyltUfnmP9GqCzc6VgHypxtRmVTh9M2nlnM/mgHsQ44HtyCKjFk20UAdpVLxqooIw3x50+Yr9dEa+uzj3UgbHS8oMUkWnJ8FDd/Ez69RaLHOS4QE6+ORBId+plpngDv04CODaPx2+kuSJxf9i634dMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq2QfszIqEj+CwO/7l7G9FNz/C24XPUM2o5bOZJSToc=;
 b=YxyJFjKPpu1RH5zsVt/nvhATsXn8eGMypneV6Lq1cvOIPWquj+DKYUIljCncNFDXt4KeHifW9J/iIzKF1cwXFn4wxLRVfzzxFl0c6taPA41TsI2MIut4qOuzqiO6jhFc5cg3Epk+TWPD97KDvEzuKT6fYY0xHBtHEr8fCgcvU5a72iXkQ52sAFKvkgcet9ucq/Wfj1kFvfa1jqjxe28v7uTTS3Op6no8nxPZZhCwdKNC0OIIr2ad/JrwSfIuhmyf+ag9TZe8PeiqqqPSwpb1yFkKJEZjIO/gSNcAfCVfAuAU3v0V5MdKOWqG6OpKFdPXzzBWMxd5dcb5+eUbEYinjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq2QfszIqEj+CwO/7l7G9FNz/C24XPUM2o5bOZJSToc=;
 b=Ecp7u3ZaougOFbiqIHktZXb1c4rl0Ph05vQoXf4wfxDetjgRkESQf9wOg3NNV8CyxMMeT8RUCuDRfLExxIb5t82ZZfIEYsBe187tltga8pUalTaXCPr6ZxQOXQhPEiQPmixaq6uGRqR6CWrjt4i1yGj2bHJsguOWCLXO4gggiCo=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 9 Nov
 2021 11:30:19 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 11:30:19 +0000
Message-ID: <9de7f807-32a6-b009-d8b7-28771c80bfaf@amd.com>
Date:   Tue, 9 Nov 2021 17:00:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 1/5] x86/amd_nb: Add support for northbridges on
 Aldebaran
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-2-nchatrad@amd.com> <YYF9ei59G/OUyZqR@zn.tnic>
 <b7f3639a-e46c-25e8-270b-04860074fd3c@amd.com> <YYknXBpOUQtV1aZ8@zn.tnic>
 <bcf5e86c-d3f1-0dab-2bed-505b1eb95f17@amd.com> <YYl0l+XV/QRZieGY@zn.tnic>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YYl0l+XV/QRZieGY@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
Received: from [172.31.28.133] (165.204.80.7) by SJ0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:a03:2ef::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Tue, 9 Nov 2021 11:30:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88dc764d-64c8-4a3a-f02f-08d9a3744f16
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5045639E760E18B22C87688DE8929@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUzc/dYAkL/SAwHuxW6dK2zBCkyNEwDQQr945CC8eh7Ex5FvO2nkzVDPmW1DIA2ShMoACZWVjJx8DJSd4JDNkJzA0o9lLmleqNCe8FanWwE7QZHTcaF+6CSyu3NlkacOMjW2nZDkgxOHMnijGiRJnrny2VV2LpaPA/ETS/qhIdG+fiEDOgAucHrMU+5FdTHk5KJeX5WSyBU9x7UPefYRkgO+vVwHCdbMvGqaZXOZwp+5ONe/nlz6FLLYgem9Qc0Hq9+CYnbC4SHQLBn3ZVscTVseops/6JOdrLsXJeF1pCF54zxiiDsSn+fx89lQa6qiOjLwpZBGAUEmhx0zafMcaEf5ItmY+bUQ9ZtojRB5RdQv+g8VERJIAwIT2QwzkiU8U1YBDLTEDkKZN1UDAme7H8Xe7G23Iwk2AZ6CAmM/kb4UG0t/YHYntWoueaOcS46TjYkohKtGXmFAJ6QKilo73rFbVoavkniqToMFNIVqVTNdSC7SdO0bvUs8yzaFEylavCWmDZyaWUWQpBwMQQVdeVvjxyTz435JQI3zC7qx67DLUqjbHfHKOylAfNAZXjfZ7jQgObZWbwwh2/3Ze8ZaZxqQ67cYPpz8Oq6/9MqqEqX6nM4Yh5B2fIBVyBFKtNsHZ0fhYb50QbtGn7ENtGc1KAtVUSysROns6TpZIKiu48Ve0yjXFk5JyzrrnQMGBcTQImxCYTXrsbBFO4jm7uwvJRY9I+H5gZn1e1GHyfYnVO2eSAhX8cmWSiKsvBvkDEhPvhUCWXAnpBH7J4/YNWdqSJBxYJlX+cjyvMdMLgRP3Lp9lb7xFCpapFApc74WxYCM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(16576012)(186003)(26005)(316002)(31686004)(38100700002)(2906002)(956004)(36756003)(31696002)(6486002)(4326008)(6666004)(2616005)(66476007)(66556008)(66946007)(508600001)(83380400001)(8676002)(8936002)(966005)(45080400002)(5660300002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNMVUdPMkVKSEIyV0V6ZDZxWlNpYVJobFQxVXlESWlFVEc2Ulg3U2RuS052?=
 =?utf-8?B?S1FwTytmZEFONzNxMXYzcURDVmhiaUtHSExlNFRLa0dmT2JqenozcGhLUDlo?=
 =?utf-8?B?WGg3TDdwdStxdUtYdEVHenlsdjN3VDhqcjZMMzRRdDBXWnQxSVZVK3NpYWhX?=
 =?utf-8?B?aEZJc2k1d0VyRTg2MVlDYUkvRHd5Qk05V2NHYTYrUzU0WE5vQkdsYjQ4UFJZ?=
 =?utf-8?B?ZytNWFBXTHRJTWFTTnFUM3VCeGwxenlLUk9qQ05WWFl4UmVvR0hJQWtESlNZ?=
 =?utf-8?B?enFBV2RBL3dxYmpSN1Q1bTBJa2t5YjlEVjVHWG0yelczcmhobSt0anBQYWo5?=
 =?utf-8?B?OG1UTlZpajRXN2RPc21RN2huMHpqL01xYUNra1luT29tT2pMMEZqQ0t6QzV4?=
 =?utf-8?B?SUpWYzJaa3hJV0VIem9HenErYk0yZXE2L0JENy9GQ1hHbnozRWg1M3BmRGxD?=
 =?utf-8?B?Q2JTV3RITFVvNXFKalFEb01wUy9LV0Jvb0NSQ2piRXZDNmpqeC95WmRveThv?=
 =?utf-8?B?RDdhVG94SVFIZkc1bDZTYzFpSzhuak9jYTJ2NWpEMXp3bUQvT3ZpQkp5UHpR?=
 =?utf-8?B?MmVaR2NBTDl0cmZScUNQM0R5MFdVWWI4dkg1Z2Zxd0ROWUgyYlJNWEpVUngw?=
 =?utf-8?B?Z085UDNTdU1JQVZHR0tjQzQvR2RYQlZmTVlNTDRqTzNtSFYzdVRPVWlqVkdr?=
 =?utf-8?B?QWZ1TVcvQzZsMXJ6L3o0dHhHQzhOcVUxN3M5TFZjVFNsYlQ1V29UaFpJaXA4?=
 =?utf-8?B?b1pMeU1YbWk4YVJKVXNtcUF0djJFYjdMd1RWdUxXeGcvOXhxZ1ZsM1NnWTU2?=
 =?utf-8?B?WTZtYk1UZ1FCZGNyL0dZdEVDbC8zVjIrU05UVDdDc0JRcXcza3RqbjZPQWlu?=
 =?utf-8?B?aFc1aFNvNEgrc2xjb1lnZ2tybVI1UDFFdFR6OGxqY082dGdKa21VRTJCUU1x?=
 =?utf-8?B?SWd2eHNyN2lsT0FPWTFUMllRVUo2cGw4Q3ovSTM5VS9WNzAyOFJpN2luMlc5?=
 =?utf-8?B?VmNHeXUzYXE3ZUVpYndOV04vRVBNZDVjQUFDMm94SWlSeDhxbzE0ajYwYWts?=
 =?utf-8?B?c21YNysrRGlHM2F0Y0tBQnUxcjRNZWhOdXFNNVJVNjh4aHRyei95VlNFSVVZ?=
 =?utf-8?B?ZnF6R0FVN1c2TnB4RFhRMUVMR2ljOTZrc2RQVmgzbzFoY3ZrSU1XcFkycnd5?=
 =?utf-8?B?Mk1udkpTdG95UnpQMWRQWVpZRklKVXc5MkxIa1MvODNZWElFd0tmZm5pbnZa?=
 =?utf-8?B?OWRqeDVoR2lOdnhlWklJcHRiR0RjemhsNnVPUS9Zd2hoT2cxQWhTNytPa1VB?=
 =?utf-8?B?aHBudlNoOTQ5ZnlNL0lSZmZWWjBuUEtDWkVmYXVQZGxSSkgxeXF1bkZTVW1D?=
 =?utf-8?B?cVJUOUtLSGEyNnk5K2dlWkhEVDNsYUdIdVliTmxtRUxvakJhSDVNUXRWNGkr?=
 =?utf-8?B?ZFFVWHNvbm0zdnk0M1plTGhHTm0rNXVUUTUvMHc2NmFCeG1pTUxhWGpocWpX?=
 =?utf-8?B?eFZZbDVMVHlybFlqWDFVOGlLcVdRVUNqdHYzZVF3VHA0TG00NkdDVkdzSlUv?=
 =?utf-8?B?U3V2RjUvakw3NHk3SkZpUWdGYXJraWdjUThtUXRrU1VYc1BtOEZ2VmxuNmRl?=
 =?utf-8?B?QzkzK2thbW5wckZkR3UwZGZrckRDVk5tMmJTdnZTMDR3Ukt0YlNrQXVLRGxr?=
 =?utf-8?B?ZTRGSDY1cWNrQVlSb0hUaENKdEFiZFFtZFdqSUFiTWtRbTI2WTV2Nk9IRFpC?=
 =?utf-8?B?TzAxYXdHOEtpMC9wOEZkUklmazdDQlFLa2xDcCtkSitwWmN6S3ppd0UycTNn?=
 =?utf-8?B?RHlWOTRKdTRieWhiWEhaZ0hhbnlwWEF4WHV1cmZIT3BBalk4QXpYZmF5WlRl?=
 =?utf-8?B?dWxJdHJpU2d2YWxhbTN5WklEQ0dBckFOSUtKSmMyMUhyK0hwQlE0SFk0TVpa?=
 =?utf-8?B?eVMrOWEzM1JsQUw2NW5NWGlsQUEzNWRwZUtXMnFQdmFqM1FNeUh0MzZ6OFNZ?=
 =?utf-8?B?OGJFdWVkSU9iVGNpRm9SMWV5azZ0S0p5QjJOcWs3TWViNEhCUlIyM0oyVmIr?=
 =?utf-8?B?ZjNiWExnWk9nME1SU0xoUTl0dDVmZGJGa3FyeitDR0N4RjFXMHhyZFBQdE1C?=
 =?utf-8?B?Z3lyQWFTQ0lHY0NtU3hlS3Npdm5LZUJ3bzZpL3RMY2hkQXd4QjZoWTZtMFIx?=
 =?utf-8?Q?wcnGp6somHEadrnKe03vsRo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dc764d-64c8-4a3a-f02f-08d9a3744f16
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 11:30:19.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYT6A+gRh4Yc7rzd/coOPvlsjDWvq8p9KBd/8FiFHZLyCNBO1PC41jMeP6xJFfSyv/b3jYX20o0xOqO75+upwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 11/9/2021 12:33 AM, Borislav Petkov wrote:
> [CAUTION: External Email]
>
> On Mon, Nov 08, 2021 at 10:23:49PM +0530, Chatradhi, Naveen Krishna wrote:
>> Northbridges on CPUs and GPUs can be described using the elements in the
>> above structure.
> If you're going to describe *northbridges*, then your struct cannot be called
> system_topology...
>
>> I thought organizing the data in a structure would simplify the
>> initialization of cpus and gpus.
> Ehh, did you even read my mail where I tried to explain that sprinkling
>
>          if (gpu)
>                  this
>          else
>                  that
>
> all over amd_cache_northbridges() is not proper design?
>
> ;-\
>
>> I will modify the  patch to enumerate gpu northbridge info only if there are
>>
>> gpu nodes with  pci_device to access the node_map registers.
> Why would you do that? What's the advantage?
>
> How about you answer my questions first so that we agree on the design
> first before you go and do things?

I was trying to handle both cpu and cpu northbridge enumeration in the 
amd_cache_northbridges() itself by reusing the existing structures and APIs.

Should have seen this through more clearly. As, this is working well for 
the following reasons.

a. Allocating the amd_northbridges.nb after identifying both the cpu and 
gpu misc devices, would extend node_to_amd_nb(node) for both cpu and gpu 
nodes.

    It is used extensively in this module. However, the roots_per_misc 
value is different in case of cpus and gpus and that needed to be 
handled seperately.

b. amd_nb_num(void) is used by other modules in the kernel, returning 
the total count of CPU and GPU northbridges would break the existing code.

I understood your point now.

When we create separate functions for caching cpu and gpu devices, is it 
okay to create "struct amd_gpu_nb_info" with the following fields

a. gpu_num;
b. struct amd_northbridge *gpu_nb;
c. gpu_node_start_id;

While, amd_nb_num(), continues to return number of cpu NBs
Add new API amd_gpu_nb_num(), return number of gpu NBs

and modify the node_to_amd_nb(node) to extend the same behavior for gpu 
devices also

Regards,

naveenk

>
> Hmm.
>
> --
> Regards/Gruss,
>      Boris.
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Cad9aea0ddff0446d80b108d9a2ea867d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637719950521959255%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=PthEEyzphEyN3O1FrUcvKyMF%2FEb282qifUHPR6psFhg%3D&amp;reserved=0
