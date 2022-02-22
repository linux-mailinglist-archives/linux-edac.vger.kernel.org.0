Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710C34BFF10
	for <lists+linux-edac@lfdr.de>; Tue, 22 Feb 2022 17:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiBVQnB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Feb 2022 11:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiBVQmz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Feb 2022 11:42:55 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3061C7C34;
        Tue, 22 Feb 2022 08:42:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbZNZGSpnfki+0VhKZO37wO9HZXXvElJXHKLvhrws1cc0tAe7uiB9Yy2tGZE5rdYvn9YbxFXJJGEpDtox5y6ujU3WIvh6SFhtsyw2Zc2v015QC0F4jyQWPRQ8/Dw1HtcJULaiIfP/X8/eVKI07AxZ3ZKI3cZxR2ns5eLzPvYDmQKvOs1XhKE4axUpnVYC8g+tf19AwLPgAg8pM/W590K930r79XOmngKZxX6YvdEQXArfb9hzCcomCjPfnrKdALZGdo3cGmkiOkMGs5OPjCupgBbZE19LRF62b+auwDb9Xhxtq/MCeKQ0DH4cvBFxAWI/huq5JPGkRGv8TRq7Lz9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riaFvB6q3wpD5rV1DmSa0KFwJdSDXj7od4qXijZy6lw=;
 b=e1cMBTkEnwRtnmXpBBrPVPROvxuYELVQNH7yA7aKRfDe+hBRmTrBc/3pFiqIePjQxNpGaJM4ScZiEIH4tpPxwkD9MzanYij5t3RdsPd1gYPfwQLbjsQZJxDqEVq9KApNJY6ZQkLUBRMKo7xp/JZPD6zIqDQso3DAr48/WnWkoyxc15utMRiAhBNqvbeAVcwfncR0tg4ZzdZHbp7mIBbGuP0c4OV/Hl+qWxbUwV8qcxaDCABQ1M8zthCGJ46MViWVpTlgEjDWmkWlQjx3yRnLFUiJoQ7AZld9DhuDBXGqt0AeQqwLEq0OPWQYyC7M7slYXscsCGagcFQJjmkk13umIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riaFvB6q3wpD5rV1DmSa0KFwJdSDXj7od4qXijZy6lw=;
 b=SmCKKn3PtkXHvunfGUUHCwVHg+tWS3m8+qEL63liTwq7FBfCs+hW/qeh4+8GklA4E4aWmstaeavTFT06GiJtiYWdD7w/5QvJ1vuQpV134Pi7eKBjW2UmaQDZHT+e3+iEzvPDRUZTqd+32eqYFrFGF1v8Ew1EpNid6NtrRv1puEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BYAPR12MB4600.namprd12.prod.outlook.com (2603:10b6:a03:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19; Tue, 22 Feb
 2022 16:42:27 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 16:42:27 +0000
Message-ID: <4e638a79-8b2e-291c-3b91-57677ffcc1fa@amd.com>
Date:   Tue, 22 Feb 2022 10:42:25 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] x86/mce: Simplify CPU vendor checks for AMD/Hygon and
 Intel/Zhaoxin
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     tony.luck@intel.com, yazen.ghannam@amd.com,
        Smita.KoralahalliChannabasappa@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
References: <20220222155857.276286-1-carlos.bilbao@amd.com>
 <YhUK87H4PQ22rpLw@zn.tnic>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <YhUK87H4PQ22rpLw@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:208:2be::19) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6649680b-e8ab-44ee-ca9f-08d9f6224f7f
X-MS-TrafficTypeDiagnostic: BYAPR12MB4600:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB46008817D0F91ED7575635F5F83B9@BYAPR12MB4600.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QbYogtj+ZGB2fMJ36hNqcJV9kmIhbMA/fS1YyqLQwRKFvz3UlKXMB/5y3NGo1r0PSAMAgLaNJmXVXqUwsCY0V6GPuIherm15MZbaXhg7dONjCeOAdErHSclyhxLD2+0YJyUGSaHoUukGkf87KkLs0AY7j6YpWOx3R4ziP6B5ZRKGFsYZF7q5pl4cRVHKornDDocoFwHQQyZYZQpAPLiy/MAGazvbt/GK7c6qpTA67DefJL8T7hVogCtxHXcjGlk6kerPaBaM3/0BvtQ7syfq5HFLd4//m8u6W5GxRqQ9+5gEpLOpRFVtpH49UO+pmPFBAbJiCpKHYHgi6iBHPSya0tdm+HhTGB2GDs9nsw50LO7oHIqHucyPGBitxLmz5Kvh+3naPePJu/IEyhcgDvzQhIxXK0pt/SoRf5Z/Rmp3qzqRkSVtZCdFTuQZYIE5TmRMX0eqiQxxFmNMkiikM9B7ZI4nCqb225SZWZYEj6pKJkSJDWz50MQXou/e32jesBQAWl1ov4T09xtIY+6SL4m0eZMyJZSZTdOxoQtxlSeuMHnIYiMK3gQoW/0gSjmrhronyqjNhs3jgOSXvsPbxA4yUUUE5MwyAFgYdMX6VzuKxTzCIb94z/f/zSrePkdDCmDKnntJ8jM89aulMXkMUyL6lYxZJxL0DwaCKedIqczwYM8vYCJy7L51cZyPy/p9Pt5w32qVEaMQE/a2KtYVoPQsxPaHN1BsCntxH56ybe1hG89cacKeoyKO0dBfVlBpjMd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(4326008)(66556008)(8676002)(26005)(8936002)(66476007)(186003)(5660300002)(4744005)(83380400001)(66946007)(31696002)(316002)(44832011)(86362001)(2616005)(6486002)(6506007)(36756003)(2906002)(38100700002)(6512007)(53546011)(508600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE1zeXJoazB1QzdyUmRoM0x3QmtFbW15WnVKQ3FiVjMwT0x6QzMrSm9LVlhB?=
 =?utf-8?B?Zk0yYjhacVB5Tzd3VjBJb2I1ZVAxdU16THdHR2RIRmZEb3NIQjhkWEd5WmlW?=
 =?utf-8?B?ekQ5MVRMazNWakYwL3Z4SENYN0RUTTNZRnFEOW5ybUozNVQyUWlielAyV29o?=
 =?utf-8?B?YlVHcnFsM3V3amVCajd0OWtpZVhnSW9NYXJWQnJMSi9kN0gwSC9vT052NjdE?=
 =?utf-8?B?RnNDdGZvNVpKamhBc1FwWit6Q0daZVhGN3RVOWlCaVBRVDBKRDV6UmlCbHA2?=
 =?utf-8?B?ZXVJdlBVNnJyWDJMWmFYbWQ1UEh2K25leG9PdWRQYW82aDhPSk1tVTlZd3Fj?=
 =?utf-8?B?Y2FrSU1LM3hvbGwxT2tjQXF2M2p1SHYyL1MrUFRHSUpxd1N1T3ZlUnVsbHJX?=
 =?utf-8?B?TDRJbDh1VE9nWWY4SGwxdkY1NEVCbG1tdTVjWUYxRVNlRkw1anBwMmJuM3ZY?=
 =?utf-8?B?RWt5M0tjc3ZOWno5NXFjQ1FKVlcvd0lpNE1GVXBucnhBVGo3SnQ3aTBaR0c1?=
 =?utf-8?B?cDJ5c0g0Z0hJSk5FMFlNM2hvYlN4Z3ZTZEVaMURmM1N2MVQzVjlhcnRJMHlr?=
 =?utf-8?B?cG94Y1QxUi9XZHZCN0JZQTA4WlFnQ3JtSnhCelFCK3pjY0JTKzFQZmM1M29P?=
 =?utf-8?B?QnB2UndDc0RTRGdYaDFuNmlJSlloYXQ0RUVWeFZhbGFQQTgwUElST2VuVWFq?=
 =?utf-8?B?S0VyOWlBVmVjUE4xanA3aUZJd1JtWnQ3NFFPM1ZuM2lPcGs3cUhic0pnSUpX?=
 =?utf-8?B?MVM1K29yWExRYjZCV0dmanQ3WGpKZTVKN0VsblU0U3BMK3ovRjFSdUZjZGlG?=
 =?utf-8?B?TFJhN1hQcklhR2JLdmdZVFFlc1JQZkdRM1VJalZkVSs1KytrRUlUUmNyVjJ0?=
 =?utf-8?B?UndWQXNEWkVKdGZMTkJlT1NuRGI5OElOL1RYSUxKQnhuR29VMi9jYUVrcW1W?=
 =?utf-8?B?TVRsYWxLYkNJMm1icFo2cEF3TGswTkVMbi9zL1NYYndzNG9YWTdTaGczMTV5?=
 =?utf-8?B?VnZ0aHdEUmUzMUJWMk55ditjRDNtQmoxdWNyeENIbG1qeSs4VG5SbjZEbmFI?=
 =?utf-8?B?VjhvUnVad1FBMlpHVlpaMjhBOXhLRHVGQ0Z5b3B3eW1SNnMvYzJmMlAyTzRD?=
 =?utf-8?B?RFdIbm1CNG5rSFVPTURRSGhtbm0xUk9UVFNCVldNZ09LQlNwdDJveGROdVVX?=
 =?utf-8?B?TjNTVE5VOTRjUEVyZ1dXSU5KMUdqS2dEVkNIKzh6VmhBYmN5c3V0R3YxYnFu?=
 =?utf-8?B?Y3AvaEFOcFZQK3QvTlQvTldIcWFXcnYxNmdIT3gyRzBlcjJVWlJuWDJiRDZB?=
 =?utf-8?B?eVExMDllanhFWm9PbGtHdkxhektZNXRUOEhLcXRGemwzTHJ4b1dhS0RsSENq?=
 =?utf-8?B?QmtyVzY2V3UwZmZsZEVWbUxIa2ZhK01pZG54UUYvNVB3c0NoQmd3NTE1cGZr?=
 =?utf-8?B?b3BqMmMrQlNOVXRLd2thN25vWmM4MzhEaXRPSWIvTTVwV205bmxkbnpCQzRo?=
 =?utf-8?B?S29RaS82OERqSk5WRVR4bFFOd2puMnBleG1uaHJrdnhaSzdkb2hRcmRXVzRV?=
 =?utf-8?B?aWZ1VW9pVStsaTF3dmRoWUFDeEVzdjNiSjQxVkxIdG1rNS9SUmZWMFVMdHZq?=
 =?utf-8?B?SlRDNlJNYU1lblJORTJqNTNGWTdLaGZhN0hZRk5tcFJESHdxZ1lRZU94TWV5?=
 =?utf-8?B?dERqY09oQjN6akxsK01qV0FTVUhRRVZWeGZTQTVxR200Wm1DUkxQOFBETlVK?=
 =?utf-8?B?QzRYdTdrU3ZkaFdacDh6YUY0azdHREZydW5lVFRIWGM5dnVmVlJGNkpuSytN?=
 =?utf-8?B?eVpPTnBwRVg3ZFpKSitnZk01M1pnNnRCMXdBNHVGbzVEUzR3RzRETGNCZzlq?=
 =?utf-8?B?Uk9GK0MyT3BNTDI0NXRPL3ordDZsNWFQZTc3OXB0SnRYV3BCbmlDbDRLNjlY?=
 =?utf-8?B?OEY0bGhMTTFiUkZVaUFrZXNad3RvSGFLTWJMWWtTL3FoYVFuQm8yc2FDZ0ky?=
 =?utf-8?B?aExqZTB3RnpGSGZnb2lyWkNKRmdjUUZyR2ZHZmZlaGtZSjd4V3BiNXY4V3Rv?=
 =?utf-8?B?SlFoWnR2cUc4R0RFeExBb09iVStlWnlhWDIzOXFwUUFFU2tDV2tyQ01RZFI5?=
 =?utf-8?B?eW5PeFZlR21kZUo4SllMNDhYblpRZVhlZEpoMy95SDdCNHlIYWVUaVVwTldh?=
 =?utf-8?Q?XlDQsWP+ev8fdXpenLbhgj8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6649680b-e8ab-44ee-ca9f-08d9f6224f7f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 16:42:27.4137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NV8Bp92p8lhSoBr1zxzRaF9EJMak6FzkFIZ+oHu/jQoRBAT0budUPWZ1HyUV9MwNBFBYcRfQqEoM5RM4QJCEqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello,

On 2/22/2022 10:10 AM, Borislav Petkov wrote:
> On Tue, Feb 22, 2022 at 09:58:58AM -0600, Carlos Bilbao wrote:
>> In a number of places across the MCE subsystem we check if we are running
>> an x86 processor from AMD/Hygon or Intel/Zhaoxin vendors. Simplify these
>> checks with two mce_flags updated at CPU MCE initialization.
> 
> ... and what's the point of this silliness?
> 

the point is to simplify the code (as the patch stated). Since we have 57
bits reserved but unused, it also wouldn't cost anything.

> Btw, you don't have to send it to my *two* email addresses - one is
> enough. :)
> 

Noted.

Carlos.
