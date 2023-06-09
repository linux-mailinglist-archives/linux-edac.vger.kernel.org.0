Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2D8729CDB
	for <lists+linux-edac@lfdr.de>; Fri,  9 Jun 2023 16:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbjFIO1f (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Jun 2023 10:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbjFIO1e (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Jun 2023 10:27:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6843A9B;
        Fri,  9 Jun 2023 07:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcjRxP5RR3+K74pjAdVMaorBH8fQn/dFtUhbKW0nlCHULuEy4/Zx6cw47KYjIGaHUiCtqS8gA0/q/go4OGYEpJGTVwP+5q1hi0MZY5JNx7g6Xh1w2hVGfPsXLh+HLLbOhtPoD3qC+jepcBRVkyylFlHHmAMOX5GAvnURwVXNLjyf3BNJ8WHL77nHY24wwzaHuEzhYgBWfiFl+1MANa5X7eqTf1uFomJiJAJRJEDAf3LkR0/OeWltkk+l1oBkHu+JvM5ZzO4yCqniskPDu3MVsy1cXeU9tqcOncsx1Qb4LZqEaJlN7RdGY6D3JOS3ZSa+qYdhXCpWCjAbStChafYBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Mc2wBD16je1W4YCpDMD+MnDSgs2AUKvXhyNzNqiHp8=;
 b=F0upZT4axL2OFg2gvo8De0WUITlyoNsf57za47KO2ETJCqdJesoQpUoJbYciTvXTrVEpRNKEN3UitAyCV5a1V87swTwsFo5C8m+ZpuluEqEgfRjNhL2yY+px/aLWBVzDgDpXgccIdakvs+6bNukhp5/JrkJ4SVoDWIJDcaDoAmPqA3uzutfJzKAjV7+pDyE0RLNjZNixtka1CTFkPHbvA9wnvvCX9nGxCXEKrHAA1UHfYAM2TI6nhlzbmav+uzU8FlgqnSRgXWpf0b35y4erYnkSH20cw+0K+FSNPYfe3Jj0GfM53G8MeNS9X0drQ5AEU4GFCFIPrqo2GKYzuek9Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mc2wBD16je1W4YCpDMD+MnDSgs2AUKvXhyNzNqiHp8=;
 b=OCMACf4OzcYTjfQAjYqwAS0f5uK1bS6hWzyt2rvBnoOf06p2UtDn9axmUextDsU9UZZKxe2etO7Q6igUy3RTtv6mmUrU8+9JEzMytdTq604r5uF/12Wn5f2xfThz9Hx++1XTPZxdAhyZKw50g62fEWheJHGb3iFRROg7DqZwPVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 14:26:57 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ca6a:7f77:6bb7:17fb]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ca6a:7f77:6bb7:17fb%3]) with mapi id 15.20.6455.043; Fri, 9 Jun 2023
 14:26:56 +0000
Message-ID: <96f6201e-8c33-a25d-7ec3-00769f67869a@amd.com>
Date:   Fri, 9 Jun 2023 10:26:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     yazen.ghannam@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20230417162006.3292715-1-yazen.ghannam@amd.com>
 <SJ1PR11MB6083E6A167F4542AB439F09AFC9C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7b316c31-ded2-d6d5-0315-dd4906ff833b@amd.com>
 <SJ1PR11MB60837EAC6B0AA28AF7D16784FC9C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <SJ1PR11MB60837EAC6B0AA28AF7D16784FC9C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:408:143::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 749a68f1-a14e-47e4-cd4d-08db68f59444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwLA7GWIp+jzDhe1tdqBOmdgvNhwhzaZvngAUmtI0C2v8Y/FGzQII2bktzqEDgBnf75W7/O/NRxAbXdO0ex3Sb0vc7IP0rUnjBk3DlZT6QRKWRJ7vtudCEY+eKeuOgXOLk9/Xsifbd6xxMBgouWthGQHJz0dJsrD9/oactEpHAAnnp/ZJa287od/TxmAjazal6MX3dWWXVdkedQf+V6a5PPS9yi9aZtBxNJu95crRpt6on3cAvwpOxFf7HiQ25p+VBD0RUThB45lMFGlPjLtd6LAWAJa1xoE/WqaJSrrIUGVF33wQLy6G0xQTnXfmlhPryi8ubrUG8i3la0cNqkftCJ4J61hUjXefysVxlL4GPpiloP3AP3BFysoeWu02bshr6c3tE1/D4hsHJL1ngnyiuKQVadkc/ZB4c0JBjsKVEPzojqAR5PwJSnHgtJyIxugf4zK8hst0JqXvZkk5biZM+UeJv/GVzLs3Sp5aOo5FwLTwE7uxbXkS7E52Ea/r/Ns3YF/82agul04UWL7x3chcY36wGCqyYdABn8QI8vb4kbNHl2+5oKEqKHQ2sGdqQzW9HpY7VXwNapGPE44wf8Z4QrUDfLZ4FkPJeC8UwQf377EKLWWXZl+ab5tnWv2+ae7Ij2eI2bz/xUAXm/awkLxYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(110136005)(36756003)(4744005)(2906002)(54906003)(31696002)(478600001)(86362001)(38100700002)(41300700001)(8676002)(5660300002)(8936002)(44832011)(31686004)(66476007)(4326008)(66556008)(66946007)(6506007)(6512007)(26005)(2616005)(53546011)(186003)(316002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUcySkNsckxoRko3Smd4UnJ4ckJuTks3VVkwTVJ5NlBEVEM5SzVSYTZ1Q3ZQ?=
 =?utf-8?B?TEYyVzMrNTVOMmJMRGNOdU8wQnNMTHdDcGZBMlpPV0lINlNSWnNjQjNYUjYv?=
 =?utf-8?B?REFxemhDSTBlQVk0cUhYZXVPZ3lOR0pLL1B0UHFMcWI2UzFKSEhMR3ZUU2JH?=
 =?utf-8?B?MHRiTnBZZUhwekRCdHVhZUVpRTRDQURuMGNqTDZvODVqeURkaU5uWFl3ZVYv?=
 =?utf-8?B?VUxNM3hXSFI4Ym96TnlLTC9oQ2F5dHNTMG5BNEw2OWljN21OcFk4VEZEWFoz?=
 =?utf-8?B?T0FNa0R4ZW9NSk52WGFsL1JoS3pqMUgyQmlHWlFpaTlpM21aZS81bURHUlZz?=
 =?utf-8?B?eTBtUTdPR3A0TG0yeUtCZXA4RnR4Z251QzRWL2xWWkV1ai95aEx1b3prZE9K?=
 =?utf-8?B?cks3MEVUMURDY3VKNEVnNmw2YUR6SlZEMGNUclpnOU1RVDY1d0RjbFlrOFEw?=
 =?utf-8?B?TmpuSE5LVTJCNng2SWc0Y3l5VnhTcXlnZDN3cHhxRHRveTFhRUtzMkwrV3Jq?=
 =?utf-8?B?RklobnZJMSs5WkcyZG0rVk5IYlFOYWtaWllObW1KVXlPWkswWUc1ODZXajlz?=
 =?utf-8?B?TGlMb0laVys0VXBhQ2I3VUgzdk5mYTNCbE1kMDdSMW1xM05QWXdVbGNxbkxB?=
 =?utf-8?B?TmxoWUdLbDVVamdKejk0d1dKaDNkb0VEYWtCRnRUelBiS2hpanBITTVlWDRM?=
 =?utf-8?B?MnY1SXptd1MwcXRMbGhBMDloSnBvc0hScHc1SjBXcS93WWhOSk1TNmN6NzZa?=
 =?utf-8?B?ZjdIRzRpdWduR3p0M1l6aVg4L2tuOTRGNVBSVUVtYjhGZTB2SnNkb2ZaNXJJ?=
 =?utf-8?B?ZXNVYk02MG9mWVN3OGlGbThZNkdRRENobm9BZlFHL3dOU29zYktaMERRcVh4?=
 =?utf-8?B?aDJDZmJFSnpXSzVXSDFRNnBBN3RyWWt5cXlEd0tBNU5xWnA5dExjMFdXdkVk?=
 =?utf-8?B?SEl3akVjWHVQZGk0NGNSRzd0a2hidmVtUUZjc2IrQlI3MjhRUW53anFoVjQz?=
 =?utf-8?B?OHNmakwvUDRHMnNmUkNHRGtsdmFDbTJ2QkJhbUtYUjVML05sa2FtdE9kY3pk?=
 =?utf-8?B?bnM3MlpwSU9kWlR2aWR1ZFpyMHhya0g3UEFmUU5qcHVoQVhQUURWRmJOLzF6?=
 =?utf-8?B?TGlPdTdQeUQyekxTVzBVb2UwZHE0TzNGSlR2MWx5anBMdWI5QXFTM0dDcTA3?=
 =?utf-8?B?YlNBdnZBdGpVZFZaQTVYUjM5ZU81SHR2dWxYNXNua1NFa2l5OUlNT0pXZ1Rl?=
 =?utf-8?B?QzB0dE01NEhHUVYzaC9MdytMY0UzNzVodE1OdElkVEJHS2oxd1BwU25XSzFV?=
 =?utf-8?B?aXl1OUhHR1dldFhXYUlFYWgvcWEwazBVSSttY3dXMDF6L2VYSjhlQjhRQ3Bh?=
 =?utf-8?B?SHhncXd1TmhkM1JPS2sxbEhiM2IrNUVvU20wb3VBRUJkeUt2Zk1yOGFIWlNM?=
 =?utf-8?B?REFqeWN2WTFBeXYxQmEybmZ0eHZtbFloS21PR3FRdHVHNUVpMmg4M2xXRDJy?=
 =?utf-8?B?a29iWjJvM2doYmhXekU3ZlYxT0FRUUt2YVR6WVJ5YXZBSDlidmZlcG1ONG80?=
 =?utf-8?B?VHk5UmNTZXZ1VG1Sa2hlaTRTN0U0enFrUll3Zm0rM0JST3pybXp5M2k1RXp3?=
 =?utf-8?B?SjUwRURIYWFCMDV3MDYwSm9XQzgvR3B6aWhnOWNJeHNObjZ3SG1tQUIwRnk5?=
 =?utf-8?B?VGVGcC9rOE1oZjd4ZlhSL1BvWlZEQXNucVlRaW9KZ2FlSTRmZThrRXhmWVZu?=
 =?utf-8?B?ZUt5MU00UHN6RnFTbkZmUTFXT2xpUW0vR2pjOTVGNEwyV0RUYVl0akc0N3hy?=
 =?utf-8?B?UXlCeEZOU2VHdGZrb095cGFMSEF0a04yZEgrZGpUZXNsZ1BSZG95dmROU3dn?=
 =?utf-8?B?WjJ3eWtBdDRIcDRxQlRBOXZtRTZwZW40QndndlBjRkpteHpKZmx6N3hVUk5z?=
 =?utf-8?B?TFVtRnh4Zm1sdHZmbkViWUN0N0NoU2pWS3pKMTRPWjlkQlptZFlkOTNUUXNz?=
 =?utf-8?B?d0pFM1ptTEFTSlpsb0U2Si9TOEZlY2JNWGdmZXIyd2VNeW1iRzZaN0xSYUty?=
 =?utf-8?B?Ti81K1l0dE5kSHRwbVpuRGVFQXRhTk5hREN4QmFhMlRyYzZyK3NxbTNlbVlR?=
 =?utf-8?Q?umvQQTuq9NHTegfIIpmpo1+ti?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749a68f1-a14e-47e4-cd4d-08db68f59444
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 14:26:56.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sk6cgsZf8nIvSGCbWyvYQa752X/ez3Zsq8sRpd6SPJ9h0BUU5Qg6Wifdx2+2Zzsv2bl7SLXRKB4f3QSdrUXBXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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

On 4/17/23 1:39 PM, Luck, Tony wrote:
>> The function expects the data to match the "MCAX" register layout used on
>> Scalable MCA systems. CTL, STATUS, ADDR, and MISC will be at the same offsets
>> for legacy MCA and MCAX. But the rest will be different.
> 
> Ah yes. Looking at the code, rather than the patch I see that it first checks for SMCA
> and returns if it isn't on an SMCA system.
> 
>         if (!boot_cpu_has(X86_FEATURE_SMCA))
>                 return -EINVAL;
> 
>> This could be extended though, if other systems will use it.
> 
> I'll keep it in mind if Intel makes a hybrid server.
>

Hi all,

Any further comments on this?

Thanks,
Yazen
