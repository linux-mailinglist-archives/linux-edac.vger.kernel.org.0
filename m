Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C6A729DA9
	for <lists+linux-edac@lfdr.de>; Fri,  9 Jun 2023 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbjFIPA0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Jun 2023 11:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241594AbjFIPAZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Jun 2023 11:00:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FBD18C
        for <linux-edac@vger.kernel.org>; Fri,  9 Jun 2023 08:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIcVz4/nPv9rr43gAchTzRuSyRe9+DlzxjOuTvokplt8Xk/jaE3yyvqKN//JdHJZEWSQxG5CVc6or8EP/J6hCLXe03mFgQAywN38YH5tBcYZIFyx0qdq4xfUSEZY3in8ZnVnJtcmqxNj/W1YxaVLuF3dnAiioMbJguuSj9dhKq88I+rjH9zRdlXo+WBcLkQsG5J2kb2IB3pomojtWqlrWv8vnJuAmb7JRWQxaZwR3f4J1sH+1+1oWm5mEHDsAc8vvPzjupTgFnqtUkF12jX1YP7134D7ZFVHHNgFO2UQFg053sSrz6cbnW4APNNW3fbgO2kt/IybtIdJRkoRtIsJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jXkHs0izC7mBsjE4Fc5xk5hL4XpDqL+hZE0vgCEags=;
 b=FMAvNFZh9RP7+ZFIb+Qix1SSgEBWaVls5PzpYqOH+dY9plsLsiuUmuN1kD/cSUidhP7E3oFR1KChWrJYM/jO1D2oCYDoIlZp/onrTknVJJSejw0U2uyjZ06Jiae2MVo7mnwEM1CFgCvUrgiNl/FszjlGre7YC38eICZnYyH/h73vIT416HVSrop+18V7kBVU63n5wBt/Rw+WLt2t5uV5nNlZ8DFYZxO7Ks7mcMbuPnGDMiVOrxYDSAOSwiKAfktbPHEzLmB3YaWWPfUby/B/gbBC4CflvJfPgTEyqCbciPBCoOt1BCFNOtqMXyKVVv66P1sikSFsSYCQiROsHdVk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jXkHs0izC7mBsjE4Fc5xk5hL4XpDqL+hZE0vgCEags=;
 b=TOfNhiZeHpAeqRbCtLLjOKiNMilohmkHktuByTsEjCsdyM46lFhajnCw13MxIbX/4PzGsGYhBKHzPnUsLqqdH2Qh7iFtBacWlc+dj8CCTmC2upyRVRjIOrwjINEp/3lNLax/aSpkMZ0kgFqCIP15Cd2BwK2gNnC5Luq5Ba5I8YY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 15:00:18 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ca6a:7f77:6bb7:17fb]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ca6a:7f77:6bb7:17fb%3]) with mapi id 15.20.6455.043; Fri, 9 Jun 2023
 15:00:18 +0000
Message-ID: <f84cc078-6cd9-f011-3c9b-8ade98c814f3@amd.com>
Date:   Fri, 9 Jun 2023 11:00:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     yazen.ghannam@amd.com, Aristeu Rozanski <aris@ruivo.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
References: <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
 <20230605203315.GR4090740@cathedrallabs.org>
 <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
 <20230605210108.GS4090740@cathedrallabs.org>
 <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
 <20230605215839.GT4090740@cathedrallabs.org>
 <20230606082541.GAZH7thXcj7SatSNtO@fat_crate.local>
 <20230606140011.GU4090740@cathedrallabs.org>
 <20230606140848.GCZH898MYjw6+b2yux@fat_crate.local>
 <SJ1PR11MB6083807C3144C28B3E30840DFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230609101757.GAZIL8VaLwAckejYZt@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230609101757.GAZIL8VaLwAckejYZt@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0760.namprd03.prod.outlook.com
 (2603:10b6:408:13a::15) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f85e33-3af6-405a-1fd3-08db68fa3cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soxrzml62nLvtN4n1Z8KJivcDmR89BPTPs6wBf3tbiZ5Qoypj3caPhfHUn7vOWM1viGRmPTTVtj6MjzuGyQhYIPQXDHfIqomGyPbHCpln83+g6DPLpf4JtO+vNA7w1bzxkzzuaYRyLMMzuaI9AqiNb3b6HNpb6bbFm3EDJtPnlMYOwYfVa9x+CTO27JJWozEps1d/m3Hy7p6EIDNBPmkAE6DgrCJTrG3912Ne5sxlhG6tCBIQQ7obrdeRNlSQFP42E4Tmjm8YjMMCTKb9iVu64/WOJm4LWN0UUiHuTCzYnG/EdKvMX0n5QvHih8TpSWPUD54s2C9BeFrjeF5E2Yyze2SUVRd4LYYuywxvCtb4m7otsTODTkZ+hihdUA9VpOn/q0al3rqi9/vQw/HVIbSqJQ0tydcjnboeQtWstS+8/eq+oQ40Q4wvVLIqBPAQ/+G+R2FTHHbxcRDZsIEnrzmio/8VnKkaL+z9rM7hYsZMy1bQth9dxk+f0sUc6KgiG/Li1XqY/ADCyaEM9s8QcqVW7ex56Rk+siigE8BO+FoSWDwxF7++2mC85z4dDWhWPZlPrLJrYbQ4dnkvQZUfWxg8rx4Hyk3El62FuRKAeKZf3t+F7vmJvpEfxYmLfQAYjhNJlTKvUaT0bMNKV2luRDs4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199021)(6512007)(53546011)(2616005)(26005)(6506007)(44832011)(316002)(31686004)(4326008)(83380400001)(66946007)(66476007)(66556008)(6486002)(6666004)(186003)(31696002)(478600001)(54906003)(36756003)(110136005)(2906002)(8936002)(86362001)(5660300002)(8676002)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGxjVzJGSVZ3bVQ0dVV4cldXY1g4T2syZ1g2OUpIZGlVeGFVMC93Nmh4b0tQ?=
 =?utf-8?B?aUp3eWJ5czdQNEw3bnUwNHBhZ1hjbjNzaFh2dDFuL0tUSm8wWW1lSVVaVGxJ?=
 =?utf-8?B?ZkVRRVpwWUFKbVFFOWpLcTcvVG85QldCcU9jZm5laXRkUmdZRTJ3NTV2d1FW?=
 =?utf-8?B?UERmTlVyWFpGQnBBTEFkRTNqYTM2WjFqY2dGbG5Ca3g4VzJ2WE1MUVJGNHZU?=
 =?utf-8?B?UkgrcTdESkJsSG5oWVE5ajZIWHEzV0xkOFNHTXBTcmJMT3VKdExjRmtVcXRj?=
 =?utf-8?B?SXZQcmhud3oydU5PSStkc3I0M1l4MjB4UXZ1Zy92WDhubldZNDlKa3A5Z21M?=
 =?utf-8?B?MFc3MGZna3dwWmZla2JZZXlvbWNOc1RHaXhiblRVWDZ5dEh6Zkp1Q0FqYVUr?=
 =?utf-8?B?V1BVY3FEVUk2aGZjY3Vqd0tmcnh3alhnb0xJaFhHQ0haRkpxUDVOL3F3OGJo?=
 =?utf-8?B?NDVhWGNsTEMvNHlUT1pvaTN3cFVVT3NUS1VRZm83ZndsYnBIYWRVRUxIdHRK?=
 =?utf-8?B?UFNkcVFNYUt1dnkxN1hUbTFtNGlMK3Y4TkFMdWpUR0UxRmNxeWZkUGFtYWNk?=
 =?utf-8?B?cnM0TGVEd3RRTFhPRStaT2M2S0ZxcUZudnVOeXQrZm8yd0VCTlZPZ2poVWxB?=
 =?utf-8?B?b0Rzdi9lSU9mTlFnYjVkRitzUVpEeWdiTjd4V0JoRXQ1VUovYVVjRmlxemtP?=
 =?utf-8?B?eVBuWWRuRGtPdmx3TW12SVc1am9LV1UvNExXeHNCT2dDWlFmUHZSa0lPN3lh?=
 =?utf-8?B?N0ttNjgwak4rbHBCYUcrWnJFK2haK0tDVUU2Qm9nN0RvMTE4RTBsWWcxSEQw?=
 =?utf-8?B?L0hVSWE2T3E3RE9peVYzak9aVDNFN1h6WDJKUWlKYWk1aGVhN3ZVUkRvM0xF?=
 =?utf-8?B?RjZJbzltelFodGxuL2U0OC9HSm1Ta2RFbGd3Z1B3ZVdmOGIrTFRkbHQ5SXcv?=
 =?utf-8?B?cmVLOXRiV1BoQXp3UGVVZURtSmlRa1NnZ2gxQVA2NkgvaXJaY3JQOEV0blNE?=
 =?utf-8?B?L0V0MzRnZ3dXS2YxTnp6clJFMFh0MnBFREppTDBiZm8wS3pRWFMvSWFSRjBy?=
 =?utf-8?B?REZQRThOeFp5bzZPMFpCbzJxRytXZmlxNjZ0SC85R3diTG8zN2xZbXFyMFVU?=
 =?utf-8?B?Q1FEN284WllGR0JpOGI2dFFSQVZXSzR2eFRpUVlmbVB6cXFrMXBMem5aNVZI?=
 =?utf-8?B?b3hHajNGQ2NkVitxUEYwK2tCakV6Ry9peDgyYkpmempSbTgzNGJrWnVLWGkz?=
 =?utf-8?B?SG1Ic3hnVzdZWitJa3dPNU5Cb2J0WlNackU5V1BQNWlaVHpaQ2FqYWRrMk1l?=
 =?utf-8?B?UVl6VExYVzBObEkzb09jR2o4K01rb1dhVWpzTWljdEJvTjFLc3BFb1IxcWlX?=
 =?utf-8?B?ZnJvdVJPV09DSTE1NU5YZE9LV2JSUE0wMUJuVSt2YmszL3RlVk44Z0cxN3NK?=
 =?utf-8?B?L25zbTlpeDRYZWF5VHpJMUdjWGE0SWVWcEtKRGx6SlZwcVF2RjdCY1Bkek8z?=
 =?utf-8?B?cTFDZk1ROXpjdTZQMmg3ZDdkeFVVczdEQWFjYVNEWDkwQ0xtOERvdlN5ZGQz?=
 =?utf-8?B?Qm5XSnFIemNFSkxza0NzT1JlQVV1QnpYdE1LRFFPbHBPSmlHckFHa2ZsTWVY?=
 =?utf-8?B?SElpNERnS0x5M2hNakhNRVl5eUlBb1FSN3ZEYlRuYTArSnpWcmp4U2c2TFlS?=
 =?utf-8?B?TUVnTUpQaEVCbm9tMFZaQ1N3emZyeHJxaXJhTG93QnByWEIwSExHMDhSMnpP?=
 =?utf-8?B?d2lMM0NhcHJ4cWQzdjZIelpKSCs5NnFQQXorVVZFemF6U21vZ0NUWHFmWFJl?=
 =?utf-8?B?VmloR3JlTHBtSzV3VTFjaXNkaUdlQ0FYVUc5L3pGWXlUYXBtTzlZQXdWK2Jy?=
 =?utf-8?B?RklwRjRWM2lqTXFaamFRdjM5Q0xaU0hiTU9CNmpiOVhTcW04WHR1L3FGeHE1?=
 =?utf-8?B?UEJHc1MwV25QdU9DcDRhelpSdEErejRRcUVKRkFSVjNRTkJCUWExMHVrODlr?=
 =?utf-8?B?YkFhSXFMT0lBNHJxdldpYXNPendWcXVBVTBGVHd2VHllbXduTFpYN05MQ1hM?=
 =?utf-8?B?R21FdlpiOCtVdXhzb3NTeldleVBrVC8yWldwVTZ4bW56VEJXYzRZYXNQVlFD?=
 =?utf-8?Q?5nOA8sxuWWai8zLs0Bdf/wpaN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f85e33-3af6-405a-1fd3-08db68fa3cd7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 15:00:18.2097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwEtW8zDgFcI9VuyVt73a0EBPu7YI0kuydPw3Ao7UZYtO7n2a/KbhqV5S4W5h7ZH3Wf5laixCkVGQM92YbBt5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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

On 6/9/23 6:17 AM, Borislav Petkov wrote:
> On Fri, Jun 09, 2023 at 12:26:56AM +0000, Luck, Tony wrote:
>>> Independent of that, yes, we will try not to pollute it with duplicates
>>> once we know what the issue exactly is which makes people disable CMCI.
>>
>> I talked to the vendor today. They have customers who want the OS to see
>> all reported corrected errors, but they also need to have their firmware keep
>> logs of all uncorrected errors (so their field engineers can replace the DIMMs
>> that are throwing the UC errors).
>>
>> Intel machine check architecture has conflated processing of corrected errors
>> and "UCNA" (the log that comes from the memory controller when ECC says
>> the error is uncorrected ... this is distinct from the log that comes from the core
>> when the poison data is consumed and signals a machine check).
> 
> I'd expect poison data consumption not to be a "UCNA" - i.e., "No
> Action" required :)
>

So "UCNA" is like the AMD "Deferred" severity it seems. How is this
different from "Action Optional"? I've been equating DFR and AO.

>> So the closest they can get to meeting both the customer requirement and
>> their service requirement is to have their BIOS configure to get an SMI for
>> the UCNA *and* tell the users to run in mce=no_cmci mode. If Linux enables
>> CMCI, then the h/w will also generate an SMI for every corrected error. Neither
>> the customer, nor the vendor wants that overhead.
>>
>> Bottom line: This is a legitimate, production, use case.
> 
> Ok, that makes more sense.
>

Please do restrict this change to Intel, or at least !AMD, systems. AMD
MCA implemenation guarantees each MCA bank can only be accessed by a
single logical CPU, so there is no contention.

Thanks,
Yazen
