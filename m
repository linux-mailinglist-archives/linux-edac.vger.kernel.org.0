Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B45B4C0316
	for <lists+linux-edac@lfdr.de>; Tue, 22 Feb 2022 21:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiBVUf1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Feb 2022 15:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiBVUfZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Feb 2022 15:35:25 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B613EF84;
        Tue, 22 Feb 2022 12:34:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqp6wvaR5oJuTVhUFcgw1SN9ubq34GB74K0TuWJ4yZKDIPQsUixZ4THhw44TikwTtWzhI1gTV73cA5S7Xym6XHf8tcy3vmfIlLnETKo7khRzXLGm2X0OMEwqFXes7Nd2PVxn4KDfN1w1j5HfJpJfUA9/nVQcEws0km/5AfYVKcOxkU//hQDxEcSBXwLkch31KxgtBkKCLoCOE79zWTFZdfxSBpnWulrDvCag7664qRAEE1fAuor4bsBRcNWxDOn9LDwJF6CzBULqXlnVgYXypFqYurvhNXrrrufB3m6aDi04ui/3dlpvy0NrhEdcgscW2zDaTGCNLuRRtRl6LVC2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXqBx7hAB+lnrFeNA/9p8OZ/eGH6ilOxBc9JjO6cSrE=;
 b=TOBcQi8Dc2hi5hUqimJseBmdAzJ96I1P2cQ0R1YyKKH4wvnyKoWBlmUjuMsfO/C7KIEZ1Nci82DhX0A1aWWnDv3QkqDOAh5l6ApOHw2oY9SkyT6beFUJZop0rRHQLIZWk+lowTH1nqSqpo4rynStFW63vamHNnl6eSzRLpIDaGvvEMYNclJ3OLYeGNhFFeplu4bpKfdAruZgRviAXg0vqlObbmOnxJQvVTT4XWxs/cNGNPSxd7nIkB775MOUtATVdX5fSbZOA5tbDD8T4IPp5mFWYTueGkFIGd3xINUq9Ha30ne96U2omvSLfscv+O5rWwp5pbnznwBX964mMkbg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXqBx7hAB+lnrFeNA/9p8OZ/eGH6ilOxBc9JjO6cSrE=;
 b=Dut4TBZ7GMR920+9iKK3W3Muq5WgWaJ3P8yKCYcnRBHWh6+BIzjZnHsbBXf+cwNH3hPYywJnNQo/6hEtfM5ZtyPmDg78+Uxopp3ljWahFNqEDtJY/hDTw+4XTTCO0PsGzQE5ckiw0a2kw04qu02da6C8kqEBQm/lcNfOWz32D7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2876.namprd12.prod.outlook.com (2603:10b6:5:15d::21)
 by BL0PR12MB4867.namprd12.prod.outlook.com (2603:10b6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 20:34:49 +0000
Received: from DM6PR12MB2876.namprd12.prod.outlook.com
 ([fe80::50:f1fb:173c:23b8]) by DM6PR12MB2876.namprd12.prod.outlook.com
 ([fe80::50:f1fb:173c:23b8%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 20:34:49 +0000
Subject: Re: [PATCH v3 1/4] x86/mce: Define function to extract ErrorAddr from
 MCA_ADDR
To:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220211223442.254489-2-Smita.KoralahalliChannabasappa@amd.com>
 <YhUCsT/WQIrFi94R@zn.tnic>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <5cd763b3-9ee2-b26d-95b0-a4b018d7f484@amd.com>
Date:   Tue, 22 Feb 2022 14:34:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YhUCsT/WQIrFi94R@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR01CA0025.prod.exchangelabs.com (2603:10b6:a02:80::38)
 To DM6PR12MB2876.namprd12.prod.outlook.com (2603:10b6:5:15d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3817afb8-8964-417b-0de9-08d9f642c589
X-MS-TrafficTypeDiagnostic: BL0PR12MB4867:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB48676A1AB7AC8CE9DA6EB283903B9@BL0PR12MB4867.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCv8gYmUcCMoNnwKQzvqlOnlWV4JGBRekg2wUzPPrzGnMP4ephN/NqPLafnISt9EBMdf1OrH7xTn5iCdx3NIRlz8AAH/poEIk1jjQvPguuXGCd100uDZOlQpIHlL2Fxv20NTxl7s9uqZDcYgvCpvBQHV/ZwANq9eY3Vx9wnsdQ80/lYjERVMpYXDNDL2k8FH+QhdiiLz8yDBUdPH3sFIPBSiyJ0gS6E8xxwz2xTsDYqAGC/vWlk5bSoTw3zD7bHikCDCgNn6Jd0g3/tD7wP2nMGg9J2wyxEJ8oGXrCnF7GvfxwXro1C2KMXPlusuAW/FYiXtmfYEoVLVWXIZTElvTpqW7fEh7cTc8gtP52Kmu1JPfHd0jDXtWyY8W/gyJO3EdR9mFxcOC9ht3x0g/Box28lB5ZM0ZzKyG2kELxSNkD3FnG/EMn2aeUum+GP8h/KiwIrYtbxC/83ikpTrcDSRBuElWU1qCZQSfLcW7NQUEKp2jhcxYRalLVa9CPIxkA155E6V74V+seqwvB5JwwRRtGskKDq9fa9h5Vv6VjPzx5kyNco5r31umhNSuRNdEUARfTBIaTwJvf3jeLMq0Uj7H4b+87EI2W2l1FzkVOVeQGIBRF1RhAVLLG+Jk/9gFZwigbyiSm99wyNaMV2nX9ap/dreQdIfOsVINop+EVK4aAJ3G8bgN7MpPdr/tM4Cfpj7krknmvQRWFlDmOj3YbAb+d9bNEo5vtB+wNWGHilFSyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(6506007)(36756003)(8936002)(6512007)(2906002)(31686004)(66556008)(6666004)(31696002)(53546011)(4326008)(186003)(8676002)(508600001)(6486002)(66946007)(38100700002)(4744005)(2616005)(5660300002)(83380400001)(6636002)(316002)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3FYMDFYVUZDMDJ3dXhFczZSbktrVVZiTUkwbHBlejhrMENvUTJYcnVvaTZw?=
 =?utf-8?B?RkhyUkdubUhjZDNOdVhCK2xkUlIzd3NjZ2x1VVZ1eTNhaDFCL0cvVXFqK3Rj?=
 =?utf-8?B?Y08vYmxlcW8yV3VhU3lGaEthTGJXWmpFR1lmS3dQcmhGaFdPRlhqS1VMY3d5?=
 =?utf-8?B?ai9pei9SVTZscWpaRnRTSmlHaEIxbHloam9TT0RpMWo0TVIyamZaRnNYK1JM?=
 =?utf-8?B?ZUt2dmk3ZnJEeDFEVFJNT2tFWFR2VU5rcW1WZE5RTmNydUw4dlJJdWRwWEZO?=
 =?utf-8?B?ZUljQjdVRUtXYlRLMDFWYlRCd0NjTmYvYjRSekJIZ3Vwcmt5QUtJMmkvSGVD?=
 =?utf-8?B?K1l1QkZLeW9pSWFhMG9tdklaREFZN1NGdDQ0NXNidExTcXdkRnZrN0krYXE2?=
 =?utf-8?B?aDcwcGswSTZiVzYwWTI4ZzJvQ1ZvRE03ancyc01neUJmeXdrODZmM1M3Y2xt?=
 =?utf-8?B?RERrMFlhZDA0SGZIdTJMcmIrMDRHWmVubFN2cHJGczVKZFNJWGlJZDd1SVM0?=
 =?utf-8?B?dzZIWnNlVC90Qmo5MFdHTFpIWTRRU0hKS0MwdEk2TWJVWE1uWUhKSnNkc3hj?=
 =?utf-8?B?MmxkRzlHNXIvN1c0aWVNTmozZWxkVWpaY1ViMEVGMEFsTG1ETmJUNGZ0SkVu?=
 =?utf-8?B?S3VWVTNyeTl5U3VMV2ZlWEFQMTkvUFRmaG1WT2Jad3k5NlZsVHpMM0NoZGla?=
 =?utf-8?B?SFVvK1JJVWUxY1VpWlA2ZnpSZ1lrY1ZlSkJDZkw3TDQxbG5QQnNvQ2ZsQmNZ?=
 =?utf-8?B?OVZzVjZwS0p3ZnhCdE9xT2xaK2FLMmRpR1NaWDgwQ3drdlZXREhzYXRRbFY0?=
 =?utf-8?B?aE1YNnNRL0FxZ2I0Z0VCbmxYUnNGOU1ub1YwNXdtRTNERXYyWnpxbElueTFp?=
 =?utf-8?B?bTJ1b01WelhVdzVBZFV3RnVWa1kxaXBLaXNxWEVLZWlyMmZnNlVmU0hqQnlT?=
 =?utf-8?B?T3NiZE5OWUVQV2MwR1dWUUtSNWNLaVpBR3JwTElzNGt6OTVYamNYeWVybEJw?=
 =?utf-8?B?YzA4VmlsNGx2YmNMM0RMcXlqblpVTElyWDQyL08yU2dMOHFsTHU2U3hkSHB4?=
 =?utf-8?B?emd5TytFNjNsaDZMejVwY0UvTjdVbEJaU1hldysva3QzSk9lWjJhWDBmOExT?=
 =?utf-8?B?c1JDS0dOeDJNKzNxVk05blA0YitOTzJpWFhTOURGb2tOR1J1a1ZWUXI1MnR4?=
 =?utf-8?B?RGZ0c2ZEMzByNjh0K29Ebk11c0NlWVFzWmw5aUR2TldKSFFuS1dGTG91bUsx?=
 =?utf-8?B?VEwzN29DWmNaMjNUblpkNTVjT0lYSUk1aGxhN1NwTGdnYlhYNEZYSVFyV2kv?=
 =?utf-8?B?S05sTFQ4M3U2TTMxZXNKRzJxazNpckR0WE1NVDRnVlRGc3pFbHQwL1ZOSUpz?=
 =?utf-8?B?VE5USXY5QTZ6WnQ4Yjhzc3UyQXprOHRidngzTG5yckRIZDB2YkhEM1loT3RW?=
 =?utf-8?B?eUdrZyt0U1NyT0pSc2Rhcis0YzdHSUZ5SmgvQlZ4OVF0dklzZDlSOHV2NU9B?=
 =?utf-8?B?V0todm96NUkxcjNZVGdpNThkSTVFN3B1ZlE5ZlUyNExGeDU3bC9Lajl0WFU4?=
 =?utf-8?B?bFJBbS85ZVdNOUxtbzVvYXpTQjExeW1HTkJWb1VUaUw0bEJBQlp5RlVKTnZ4?=
 =?utf-8?B?OXRVTTNSb3BOT2ZLM1ZnYnRXNXNWVGRFdlBTMnBWdnZIRXljMW5jMG5Qakhk?=
 =?utf-8?B?bFoyVTNSVG02MFdsN21xS250NEJ1bTBnTGdseHU4bUZnL3FGMExuQVE4SzBC?=
 =?utf-8?B?aEV3ak5PRG9XTitQc0I1QlEwb1VKMmYyTEhXTTlWVkgzWEcrVFk2SFBlRUxy?=
 =?utf-8?B?Lys1NXUreTk4VUpnQ01EOXJaUG5mQ3cvbElPUkZ1ZS9lcUZRZHQzTVEzeVZo?=
 =?utf-8?B?b01nckhwbDQ5R0dBdGVYQjZ6RjJYa2RDcnBsc01Wd21hTDlzY0ViT3JBdjFL?=
 =?utf-8?B?WmUrMjBzM2l2cmNzVmtsMEdpZkFhNHB1RzVnZ0sxSXcydGp0Wi94Z1dLbXha?=
 =?utf-8?B?dkdrWDhHMGZKamJaeU14L25OTEc3ZWpiSWVGNk1Wb3hlUUp0RzAvaXhRYUtv?=
 =?utf-8?B?L3ZaOFFVMHlselBhazN2MEZyaXp2ejB1QkZpMWVPUmVHOFRla2VWYThYVkZ5?=
 =?utf-8?B?amJIVGtyNU1weWpYTVAvWDEyYjlYVG8vUk1QclZDRDFBelBmWW94TEFLYmpE?=
 =?utf-8?B?bjd5dWUvS2dqY2daTjVKMExrMTV2Y09Wb3VlS2FyTnVzajVha2pKMUZZd1NJ?=
 =?utf-8?Q?PijfqtLZq2LWA3fzcg2tRG9Ljg7vMzY3wdTUeEeXeA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3817afb8-8964-417b-0de9-08d9f642c589
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 20:34:49.4347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4Ro6rF1INfC4FcIXvYC0tTVZNv4KScRVO6B+9oL+LnEV4FfwSLZOkhAICs6zskaZYYudz6sJ0duoqw5GkSb5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4867
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2/22/22 9:35 AM, Borislav Petkov wrote:
> On Fri, Feb 11, 2022 at 04:34:39PM -0600, Smita Koralahalli wrote:
>> Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
>> will be further refactored in the next patch.
> The concept of "next patch" can mean different commits in git so pls
> reword your commit message to be void of the patch linearity concept.
>
Will correct.

Thanks,
Smita

