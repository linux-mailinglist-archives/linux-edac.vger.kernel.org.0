Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E796D4EDC
	for <lists+linux-edac@lfdr.de>; Mon,  3 Apr 2023 19:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjDCRYK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Apr 2023 13:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDCRYJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Apr 2023 13:24:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D327D122;
        Mon,  3 Apr 2023 10:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIsbEc6tUxKulOu58PI4WRdnVI52gTNUfylh0q9F7J7pi4/mEZ3reyJRAh6Fl23CgnaG+uHdqHv8f5N8lS1Y+eunyGyzwsRtuBdthujNCHc6im7ynurD/lS4ZAmy3QXwYJKmYFW1UGzt5gZmAJa/cjnI+JJarll92mlF+2cjZQbguWvGnGEDLbpuXpjrN6DiWfoe4bWsnXV7XHU3RJPWK7MBAuTd78Qb3As8c1ZyNm7ArmWxE6z9X89I9Eftwi6uRQ5CTGgLZAJGVuOKxqE0rmTN6PFUrVNeQ2JVmb1w7czQkGnjIwtG3dRoUrM8P5EUvq7tluuW1zREeLTUkqOmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaJMQkST40PG3e9uZbFJZOovoZA1Rz5biuVydXsEjus=;
 b=nsbIjmE/VtRzydDsAPx6n2++jYu9dWETZk20qr1VJlg0wsudkZ/pH4aYJHnmOV4XhKMKz/Be3xYvxSsFvzGFMmkl30c3Y83xiYsLEPvY5qrkBxHiH0KPalquJSQ8hu45WbehncwiaTMsa+FWWKguBgTzexdwlnEuX0bU43pbIPZoPnKk6uelfadM+qQmrzOnWyv7mb0ZCFTlSt3jMJ3bC7i9vY6hf9NTLjz4VTePUw4aAIJOSKbacG0Dx8E/7ww7RPAn8/qqOe47lsSQw/EONpVj9G80PRw5rjlL7wx7Pa+y20kRkhwuFOfMfzKD+bFBQlqJaenbnpf78rvK5aVlqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaJMQkST40PG3e9uZbFJZOovoZA1Rz5biuVydXsEjus=;
 b=g1HECMKBxWEdfP74GTv6KnjSuIJORIlk3ka2X2Ks4cpB/CNs3DlIqhJFTy/FpETzPboegZyMA7HpzuG55YNUcsUD3sdvo3d3gYRyfYJq8fbH721fXam2UHbaRhA12NY1e3m9quj7c8yA5APItcR7YrIkgK0Yfmk5qXpse5IWypY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.26; Mon, 3 Apr
 2023 17:24:03 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 17:24:03 +0000
Message-ID: <8fe661ef-fa03-5ee9-de57-eec6a5bb7a28@amd.com>
Date:   Mon, 3 Apr 2023 13:24:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/mce_amd: Update SMCA bank error descriptions
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Avadhut Naik <avadnaik@amd.com>
References: <20230329192200.110813-1-avadnaik@amd.com>
 <20230331154412.GBZCb/zO/BGR3a/bVT@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230331154412.GBZCb/zO/BGR3a/bVT@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:408:ee::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 26327171-0a94-435c-867f-08db3468388a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NN84yXVsWfwrM9ecge3QeHk9vXCe/T4HwLEM+duY1RnMXtrKFePFxs8bvR2uRUK/l56KM/PJpVZf7i9fuYCfrLgb8LNvo2XV+dnWafBnR2azaeQBojjSni1HzugaczEpAJEhQflXPBvV5U6pZWkC/+m2u9JHfdwsH0+Q+RSc3Gjp/dHx2KHq2KPG23HYuJuCWpgcFOFWzE1a5hn4DoCGEo+VvzFFLU706LlTfL0HpRqXEU2wjElwf2rtTMP48LQzI1/VdngrVRNeQ2tKNqacSauHfzBCPo08FmfpI42J5zNhRo4QBWy8kA5y2RZn/aCNOu7pWhCq8OdKVZZE4YYGHgGArVgM2QfTG9y2dqDAoI5loxI6zIzYxQHRONuKvFj9V22g5AOL/PeauJzgsARMyoRaKCqEAUqln2iM1jUy2tHbKRdsbOziiA/6D6cVP5bBOdeZctXERaYJmGvDNOkrrJxWy5ZiKpurxo1DLoUxiG5c/+U2gKp/Qh5FvMmm6rn6LqwzxRIHa8dVicwz9o3Dt3ugXviTt1S7bsLbvyiyzwMy9YKaFdL1hTdve8hSe0KkqKkJ08FakzqRL1+Q2YLaj7RmUp2vXXVTz7Q69tNXmkLyYMae6YcjoSyxIO2NJ3d4pAcFICXGpWGnNewh6U8I0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(86362001)(66556008)(66946007)(53546011)(6506007)(66476007)(26005)(6512007)(8676002)(4326008)(186003)(36756003)(6486002)(6636002)(316002)(110136005)(478600001)(8936002)(2616005)(5660300002)(38100700002)(41300700001)(15650500001)(2906002)(31686004)(83380400001)(44832011)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWlUTnhSMWllcHVxTmhBTUZjYmZGSC9aaDgxdFFJaFN0VlJvdnc0MmhRM25U?=
 =?utf-8?B?U0cxMjZ5Z3hnUlZza25Jb3JsTFNGUHZpNFpGUmJ1SWxXSCs3R3lmL0ZtMWZ0?=
 =?utf-8?B?UjhYdXJEK1RkUDRBZGhkTEpUUDBubElqTVlBSHlEZEcwYytPL0YzcVJidDFn?=
 =?utf-8?B?Q043c3Fud2xyOUFUdTNadGxLQUZLZVZEY09YYS83U0psYlREUU1TOFRKdlZ3?=
 =?utf-8?B?V0thYVhGNGRxamp4eTgxMnZHMGRxcUg3M1JLWXYxV2FJSTVYNkxaL0k2UHg5?=
 =?utf-8?B?ZncvMG1aT2RvMnJhWXNRZkl5QUFSdTJzaGJwVVpHNzVkYzlqM0JJcWRzdHBY?=
 =?utf-8?B?SGRFcjRjOFh1UE1Pekhhc2dFenNQRVQ3NllHSzU1cFFHS2ZVMWdFd3ZXRDNQ?=
 =?utf-8?B?WnVNWEZiejJBN1E2dG95WXNCTWdtQmxJdHAyQTgwWWNFOFJhUG1ITTQxVjlQ?=
 =?utf-8?B?L3hKMkNESG83Z2Y1Y1Z1REFPcUdNc2pOMU5TSGZPUFdDZDJRYlRzdnRHMG9Z?=
 =?utf-8?B?ekVPSGZTWEUvVFNQMS81WXFHemtNWXBLWUxQblM0SUNweEpxa1AwbVBpWFdB?=
 =?utf-8?B?RzdVWkdjMXoydk1ncEtLejVjcFZnYnNrWW95QUxDUzVqRzFvVkwyNzRjR211?=
 =?utf-8?B?TGczNGszMjdiUWJvVVd4b1Z0YlJQQWxWbzNwQm11OHR5eG9jYndNR1Y3R1B6?=
 =?utf-8?B?eFBFaG1Ua0xleC9hczlVQldoaWdOMEh0QmxVeTgzd1JnUVZYSlIzS2gzNTVH?=
 =?utf-8?B?MkJlbXMzVW05aW53NGdYeEFWaFBhWHNNRldlRVkwYWFWMzhvZ1VTVkFVaVBU?=
 =?utf-8?B?a0RWMXZmT3owS1dTSXVnUVdONUR4cTE0K1lrY1pCUWhnVklxUHRRYWJHUDQy?=
 =?utf-8?B?d0FPU09zZUQzMC83MFpTaGFxaHVtdmZXT1ZrSzcwZ0trbmxsV2tDRWhaK2sr?=
 =?utf-8?B?Ny92V0pneDJKRjhZQk5vNG10Z1I2dm8xNHEvczdzbjF4b1dzTUlLZ25vNFk2?=
 =?utf-8?B?UWZpRWc1TzF0ZDB0UlFvMFI1MWd0MzBRRDR0Ukx4UEFFUHJDckhCNC9yL1V5?=
 =?utf-8?B?b2oxemV5OVFiZFk4TUtFbzdCU1VUUjdKODhSaVAyd0VPQXR3c0kxVUM3SzFG?=
 =?utf-8?B?TUFycVpHdjRnektTTjNrQjNCeWYwREdhbm56UE5MQmxxaHRKUkFGQmZTOXIv?=
 =?utf-8?B?UStvRUFwanVsOGlyZ1hPck1IdkhBRm91WlNuUm51T2lTVzFNMkFJMGh4S1pO?=
 =?utf-8?B?TUJuc2YxYzlNdTBNekgyb0NoKzRhTkh6bmVJSXNTNTNlU2QvTVdEc0hFZm9F?=
 =?utf-8?B?NkkzaXRuR0NhenZONHovZ05ON0tKWTgvb3dTUlZQRkhBSFRHbTJLeTMyc25J?=
 =?utf-8?B?ajFzVUg1SFVPL1ZvaklLaDVua1ZFV1BZRFNaU3lPMzc0RzcweWhjZlFGa0VG?=
 =?utf-8?B?SjJGODBYVTJnTE9RVzllbmpWNFBmU3U5VWwyTUNTTFgyZHZpa0N5MDFzVHc2?=
 =?utf-8?B?N2NUMllqcml4NTgveitweGRwSjVJa3AyeDdBcmxtR2pTVWV0VGladDhnOGR3?=
 =?utf-8?B?Z0lmdit4TFdxaTZjYTBvWGhRcU04MGtldnFRU0h2ZEZUZDFTOURyL1FxSHJi?=
 =?utf-8?B?aHh1eG9qMUtiUmJLOUMxRml6UzdJdHBNd1NWU2VYdmxCcXMyNXUvM3p2M01k?=
 =?utf-8?B?bnJESzNkMXNzdHg4aDJMK1FJKzlQVzFqVkhqcm9Yc2dORDJReTBWWFZtRXR3?=
 =?utf-8?B?MnJLdDhOVGN4dW91alo4UC9mTEJIbk02bDlmbW9BaVArMFZoS05MREVxSUdC?=
 =?utf-8?B?M2FJcERoa1NXSE1FdHF0SVFhTi9ySktwZzJLUEV5Wnpkd0szMGloVDFBaWJ0?=
 =?utf-8?B?S2tETG9vTGVtNmlMeSs5MlZZbW5GVEZPRjlXRVk1VEZwRHF0NDdaM1JqRGc3?=
 =?utf-8?B?Qkp3QS9lbzNGNzArV3FwWjVYMndHelA4bVNqTGdVUVZCYVZYYy85bXgvU0JF?=
 =?utf-8?B?dWdQeVdSL3dkYlN6NG1YaXUyYXFlbGh2QlY1RkxhbkJzREFDeEJwMmFKWndr?=
 =?utf-8?B?a2VOZkFHdXFYS3l1aEpkNEc5ODJpc0hseDZ1NlNaZGJrMi9jY0x0OTA5Qi9K?=
 =?utf-8?Q?FfmYxlLZFGtZ+T/k+Rh83i/aI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26327171-0a94-435c-867f-08db3468388a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 17:24:03.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTxMcZBJE74oTbE+5yCPslqSvZrcZeaGpS+TGI00HIAybv5E/agEIESsbNuYlnZDMRWT6sKwe8g8h2+UECwKLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/31/23 11:44, Borislav Petkov wrote:
> On Wed, Mar 29, 2023 at 07:22:00PM +0000, Avadhut Naik wrote:
>> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
>> index cc5c63feb26a..869dcca5e2f4 100644
>> --- a/drivers/edac/mce_amd.c
>> +++ b/drivers/edac/mce_amd.c
>> @@ -192,24 +192,24 @@ static const char * const smca_ls2_mce_desc[] = {
>>  	"A SystemReadDataError error was reported on read data returned from L2 for an SCB store",
>>  	"A SystemReadDataError error was reported on read data returned from L2 for a WCB store",
>>  	"A hardware assertion error was reported",
>> -	"A parity error was detected in an STLF, SCB EMEM entry or SRB store data by any access",
>> +	"A parity error was detected in an STLF, SCB EMEM entry, store data mask or SRB store data by any access",
> 
> I'm assuming that "by any access" is not needed because
> amd_decode_err_code() would say "GEN"-eric for the transaction type
> which is the same thing, basically.
> 

That's fair.

Two (likely weak) arguments for this:
1) Match the wording as closely as possible to the documentation.
2) Folks are likely only looking at the Extended Error Code.

If we deviate to far from the docs, then people will ask us why
Linux says "X" when the docs say "Y". :/

>>  static const char * const smca_if_mce_desc[] = {
>> -	"Op Cache Microtag Probe Port Parity Error",
>> +	"Op Cache Microtag Parity Error",
>>  	"IC Microtag or Full Tag Multi-hit Error",
>>  	"IC Full Tag Parity Error",
>>  	"IC Data Array Parity Error",
>> -	"Decoupling Queue PhysAddr Parity Error",
>> +	"PRQ Parity Error",
>>  	"L0 ITLB Parity Error",
>> -	"L1 ITLB Parity Error",
>> -	"L2 ITLB Parity Error",
>> +	"L1-TLB Parity Error",
>> +	"L2-TLB Parity Error",
>>  	"BPQ Thread 0 Snoop Parity Error",
>>  	"BPQ Thread 1 Snoop Parity Error",
>> -	"L1 BTB Multi-Match Error",
>> -	"L2 BTB Multi-Match Error",
>> +	"BP L1-BTB Multi-Hit Error",
>> +	"BP L2-BTB Multi-Hit Error",
>>  	"L2 Cache Response Poison Error",
>> -	"System Read Data Error",
>> +	"L2 Cache Error Response",
> 
> Hmm, so I don't think we can do that - I'll bet on older Zens, this was
> "System Read Data Error" and on newer it is "L2 Cache Error Response"
> which are not the same thing.
> 
> Right?
> 
> If so, we can't really "update" descriptions like that. If we had to be
> precise, we will have to differentiate by family here. Not sure if we
> care enough but still...
> 

You're right. And that's why we need a new HWID/McaType if the errors codes
change. That's the reason for the other "decoding quirks" set.

In this case, the error is likely the same event. But the description is made
more explicit. Otherwise, we'll need another quirk.

Thanks,
Yazen

