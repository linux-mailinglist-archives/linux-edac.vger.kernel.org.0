Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70627733346
	for <lists+linux-edac@lfdr.de>; Fri, 16 Jun 2023 16:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245664AbjFPOQ7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Jun 2023 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245236AbjFPOQ5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Jun 2023 10:16:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEF930DE;
        Fri, 16 Jun 2023 07:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMPAt1Mil0Ae3+i+OtLojoNBtyll7eYXMSQAI59ul8kNitO4EEFYmjn5/DH7AcDh91p/dhC7KLIgYHPDt+EN8KoLZC9Q7WsB6pN4QDaVRW1DmViWCvNZEim10B4P9c0Sl/3yQoKH2Ow/ApVC+T+4IKsLjG3z+mDOjIm9MWFzz+8KfSZAbGDe2X5zDY+heGs4PmSKPuL3QrziPwadjP1X5fHfQJWDlRHcyLhM9/Qm0WsIc4crgOK0+jCQ86BIZp44RRV5Hy8/HRNqJ+H1SBEiOS+WyAiji9+tprKb4Gfeek9TXdzhhI2fCboK5zHh6oilEM/xwAkWF0JwWdY8rN8PEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vFuQ39oHjX3QYrg0BzYy/weRH17Y7wJJRCJeuAakIM=;
 b=bfO33jX/ZfCKQrngCTvU/s99oe0427uwlGy1b2SuPFzS10h1u3dWWClR5LUuO8euKCxTiWW5K+bsC2ogD2KUQvzNzcfJm/882369cYQzpl1cOcarJRQtVZPEHLPq0WJsXsWkTP6d2oB/XNjZ2oW50gySZdT5e/OMq91vsLmYPMKiZ2IHfMs/u5IbM2IGW+D5jYdTY18zKrFbrbg4ft2vSDrBJJoBWAtPMgp+gDTTiCTAPFNVvVgrX0hCkm9nE6EzPNA9/EVRtiRHum11VZ6KHrsFlRRwAlZpCvHwe+mvg/tAbfK9Qsj/ZTH3KoD9B8XYTiJNN61xqPIs8bPI6cylww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vFuQ39oHjX3QYrg0BzYy/weRH17Y7wJJRCJeuAakIM=;
 b=FpI7z9+f1z88P17aLcS7Q1oHo4NPDDH3n1gYeE/ktBWajdpKxnYOo29fDJuHbt9/pRXVn2xD8y6zl44SLakJZLVprYskm4damrwuQXIdAGESfGeF9QrG4oVD0NR+0NgK1+4jANmpuzJjKZ1BiH/OO2w6BgGN1Q8zjoInewW6Znw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 14:16:53 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426%6]) with mapi id 15.20.6455.043; Fri, 16 Jun 2023
 14:16:53 +0000
Message-ID: <471df10c-782d-f251-f8ff-59b01ed097b2@amd.com>
Date:   Fri, 16 Jun 2023 10:16:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <20230417162006.3292715-1-yazen.ghannam@amd.com>
 <20230615152031.GCZIssPyJjGcikn9iA@fat_crate.local>
 <c9f885df-4650-248c-3708-9250a0b530dc@amd.com>
 <20230615162037.GEZIs6VZG9gVs5QtFT@fat_crate.local>
 <d1333fa6-34e1-8b2a-b772-369776428eae@amd.com>
 <da1f680b-f601-0e64-bdb4-1aa5b6fc6175@amd.com>
 <SJ1PR11MB60834DD80A6193F959719CF4FC5BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <SJ1PR11MB60834DD80A6193F959719CF4FC5BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:408:143::12) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 58109517-c4a2-49ea-3245-08db6e7455aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoVUZfgaeeohgD2iPIkqfZwNd3CUPDzlldjU1bRf8fF+QgpiDqUQ1flcnLHvvTn+tPViN/wKjyIqJwCI5BUkBxB7ahc5QWNqUVWr0vz06dDbI0fjzjlUBmGATFNpnn7cdBfCDr5O0ARudS76EgCoU4zRVIf2vNoofbLWLUULEfukffEsA3+Ye3pknrNdSNmeGFgq2LGYlvlgK3x3qGwtKgelkHi5f9B3JVga0TzG1G05kCjTAjmwkqiD0zrP0NsTMFfDRWxyiv8agFkcMHnuFgG1GlHIF4w/ZbpLl/COn2hS8GrWocU11E0iaYDBNrP0pcQoQgsmOkwmOABTLi+5IYTp6DGPkgRj9BP56A4zSOyv85P1CKdmjsDR6V1/cehlNCqKGyTa2TT3ZJUG/PQBdSl1wgllUpgip4BPqw8H+2MbFZyWcNy3AtqAjJnSgfWJ/vf3Igd7VanSU1spDrBRyBPw5Lp6BqZmx4G7Glh5FWXg+nDz0WFt252mFxVdm+VudlNeB128J4+fL08hkTCIP/jQu/SCflOjOrX035832HLJfNiJavYDyXPmCKLZ0rSCG6XSruX2hYS0T2GfxEJFGxugbkT+obi213bKBxGnOBver17f+CAK5lzzTnIRbZW7BXd/WBi9Z8wn3ss56gU1Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(8676002)(8936002)(44832011)(54906003)(41300700001)(5660300002)(4744005)(2906002)(31686004)(316002)(66946007)(4326008)(66476007)(66556008)(36756003)(478600001)(110136005)(6486002)(38100700002)(53546011)(86362001)(31696002)(186003)(2616005)(6512007)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eStJdWZ6SzFvSmNwbm5SLzRXVVNwNlh2eGN0bjhwT096NHZTOVU2aGhMSGg0?=
 =?utf-8?B?ZGxoWDNoajBTZGUwT2xKMEpSSW9GRXB1aWw2c2RhZEZLUnFaa0FJWmIzRktU?=
 =?utf-8?B?WFFkUXBxSUxDSS9Vb1c3Q0IweGhvTU12dS9XcmJKY21LZEpsYjZDRm1OTGZk?=
 =?utf-8?B?OWJ1dUs4U2dYWENPZnpEaVpJa3NwSjQvdm91NnpuQ28yUE1NNlJJWFk2Tzgx?=
 =?utf-8?B?cGk5MTl1Q1lJY3ErQnpOcnF2VG9XdlhQd2phZTBPcUJGMW5sc2x3SjhhbVhV?=
 =?utf-8?B?UHh1WXJxaHdIK0xGYVZ5R0pDaE81bm9rcERXNVVBWm5nbUY3TFFqc01ZR0Yr?=
 =?utf-8?B?STFSSENWcHZQdkZmc0hGektxaVlFM2Z6cXFJTnZKOHJHNWdNSnJOQUJNb3JP?=
 =?utf-8?B?cTBxNTRjTlBCWkdnVmpNeW53YnVZYzJlQllVempuaDlYS1JSbkc5OHJXWkxT?=
 =?utf-8?B?MEdSeDZLd0lOazhYWm16YjNvZzhpYU1SclZ4NmpnbFQ0N3JIMU9lbXNlaDlN?=
 =?utf-8?B?NUNkeDBlVkthSmZsMDM0SWIyTlAwZlRjVlkrNjFicVFJY2h3Z2RkSHMxU0Y1?=
 =?utf-8?B?MW9Vd0dIL2RBMTM5aGZDakZYc3R6VnN0ZjVMQVQ2anJTZnpZZGFCTkhha2l4?=
 =?utf-8?B?VjlXMEdqQUp3a1FSSHZ4Y1BTSTFyeWFybjdaTkVrUW9tbW9ueUltNmp6UGFw?=
 =?utf-8?B?WnVTM2ZNNXpHMG9SMk52enJHOXJ2NWY2SlUySUJLRmwwZDhGZ1dVOHl6anNy?=
 =?utf-8?B?clArV0x3Ymk4amF5dGt3RjdTQmZqaTBxT2MzenVMQlFhK1NBRitGUlhSZEMz?=
 =?utf-8?B?RWRlekVoYjQ0N1V1VjVIM3M3YXRodi83UlZvUElTL010QzVROFE5eGRJS25V?=
 =?utf-8?B?OGdtOU5LeGEza21tUnJHeGdCMjdVV1V4NVBEK3B3QzN0L244VW9rZWxqSXhv?=
 =?utf-8?B?Z2dnQnRsSjVNUDBnS1BhaEcwZkEydTdLc1ZSaURaa0tGNUJjbEx3SUVocnFZ?=
 =?utf-8?B?M1FrREtYaWhKaUNjNXVhL1hBeXBhMS9heHBTcHRGZHpXUDVGR0xjaTFTWmRz?=
 =?utf-8?B?V1B6amxSVFRuckRCNVlxYjBPaEZsTWtmQXh1c2gzbW83ZzR4djVQSi9OS3VH?=
 =?utf-8?B?QTdrZUlsVmd5T3ZPcHRKdzdVcjNUL2kybGdRTkRlQ0ZFejRVa0E4ZkJ1U01J?=
 =?utf-8?B?T25sanJVU2xPalFNakJ3aGFMbGU5eVZkRmdjdHA4V3NUUUYrU2UrLzNnVTdT?=
 =?utf-8?B?YUtSR1lscXJVNXhKS0hhWm5BMXozc0k0MGxxemZQU1VQYkQxYnN5WExxa3BS?=
 =?utf-8?B?MlBKaGJTS2RKanJoZFZ0d0preWs3TzdtdW56ZFcxbkVhdEdEb1Y0TWhwSEhM?=
 =?utf-8?B?ekxsM0JkL1ZXRWpxWENUMHBIaHB3STU0UXRiQjBLK01ScDZ0d25ENmluYXly?=
 =?utf-8?B?d093ZlNDc2JzUExyYzJPdHg0cW1sVzdBMnZzVWlHSldic1ViNTdFZzREZkRV?=
 =?utf-8?B?SXBSb1dtNGZPMGRyblhlbGpFeGZYMzZBSXJPKzNVWEFoQ2N4dWFRckZjUWla?=
 =?utf-8?B?VGcxYmJxOUVuZEhpTVlmaUFxRTd1NUZQcmRPNitRaDRjSmllVjVRTkloUDhD?=
 =?utf-8?B?dEF4MXFBMzBkRk1GeHJwMGRFT0wxbUlFU0hGUzVnSUUrVGdYa2w5MmVzczRU?=
 =?utf-8?B?SGpFLzFIVk9VTjJoZnY0bkJDV0lUdUJmSjVCNTZSbTUvM0VoMGh1U3VMdlNO?=
 =?utf-8?B?ZXV6VldFc0FHL0FZRS9ZR212UFlKajlORG5sYlEweW5JMFRwMElZWnQrRE9J?=
 =?utf-8?B?NHZlNmxCb0h0TDJOZVpma09PMmF0UDV6OXN4U3RVdjhNTmNqRTA1ajkwNExo?=
 =?utf-8?B?Rld1amxzNnB0RmRVMDlXUEdNVDd0NHFMbGNKUGtDQnVURHdzRFBKaXBhdWI4?=
 =?utf-8?B?ZFpZNTZJZ3ZUSmFUUFMwUXBKc3BVdTNEV1hhSlpJNUYwNVQveDFDVzBKYlpq?=
 =?utf-8?B?VVRTSTk5Y3I3OW5zMVNNOGtNMGV5MlorR2k3S3UzNXNlNWh3V3RGYVdBWUN5?=
 =?utf-8?B?TTl6UHZSSlhObHdOUjlTVkFmeHdDb05YdkhHeHdRQzZUUEJBWTFxLy9kalNB?=
 =?utf-8?Q?8J6ohSpL2ZslRCN9fZ4azFh4+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58109517-c4a2-49ea-3245-08db6e7455aa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 14:16:53.6638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LP2MLmPrOS7CoYQAt9Ek2CXLjW0LWBHJns9tMNxog825G1un93EnAIMoLZMjwUYs/QcMV9pBsvSJTZbvokxVTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/15/2023 1:54 PM, Luck, Tony wrote:
>>          for_each_possible_cpu(cpu) {
>>                  if (cpu_data(cpu).initial_apicid == lapic_id) {
>>                          m.extcpu = cpu;
> 
> Are there any other places in the kernel where we need to find the
> Linux CPU number starting from the apic id?
> 
> I briefly looked a while back when I needed this for some
> debug use case and didn't find it then. But Linux changes
> and maybe there are some now.
> 
> Which is a long way to say I'd like to see boot code initialize an array so the above
> could just be:
> 
> 	m.extcpu = lapic_to_cpu[lapic_id];
>

So functionally the inverse of "x86_cpu_to_apicid", right? Though not 
per_cpu, of course.

I'll try and write this up if I don't find anything like it.

> But we'd need at least a couple of use cases to justify.
> 

Can you describe your original use case?

Thanks,
Yazen

