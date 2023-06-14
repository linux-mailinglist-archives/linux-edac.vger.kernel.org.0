Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33807302D8
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jun 2023 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjFNPGy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Jun 2023 11:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343494AbjFNPGx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Jun 2023 11:06:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF66198D;
        Wed, 14 Jun 2023 08:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlN6eZYUlbQNX/8M0hPMBdy+uwY6u4zXgii2e8aYF08980kaIYqG2ce131hwr3rmXVzolBOPXl5quNK94McbLj7Urn/YLKsE8Mhxflg9jb0bDQev7dTyxx8XSHcOxNehlNMCpALUJNVI3w7WadtrOBP0Sl5RJYHdfa77sSi0W1qhlef/7sOfmVzNO2N1Xe6SaQbiG3DprDly3+p2pb7bPoePxEDL5y1LV5lngYQqCXwYfDMcOiPsDXaMKKQoNCxUOeiWv9VF9Nlo1NejKng3OBHHOE1w7mtTwabo2O2OoyNAZvDXEhGyiRadZL1B49s8x3LthK3WWBF7ehZoCKh6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHB+3sk9oy1M6lbq3dkHZ9b18BX8eMj+vByk4zBHs4k=;
 b=fVvc2/FvnxBetlPdzZr/bOP4shIkSnfjFyx2LBg727i4pDkCcAyBILbdVHS/D5nGkbPBuG/g8XRURguisMa0y6HeZw8YtzqVv0nrXSW39m4wm4LSNkzfcro7O2Q0h6chJy2tr+J+HaSkQZ9mgpZVCRI+SyIYoryALiPUQBfvxVdHPAXsXqecN9ZbJamgmbfnu38fRCaKOYJkYWDiepsfSkHxWzcZ4rSkSwnUhixsCina7tY2jAq5XAOe3j4ewfT7CVqk6yzA43F4njwwKBdzbi/V6afijpbs+vRTZp0xoI+EU1lYzd0h6Rqw7uf9YKizK4T7Rb4hjx7rqY1GfV7K/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHB+3sk9oy1M6lbq3dkHZ9b18BX8eMj+vByk4zBHs4k=;
 b=Y/Bme+JLTPHKsqt9LLYIujm1pgN0mRDULn26IA0mSu3x/R/2nv78uAUpgeFAj4nKNPsq0bkIDg+vV+70P5eXrBBqMw1AHSR9RHire6XYyzXvlCdOzwXJgtgF/EuadKBh9UmtYroFO9JHRVCLePnSIdLWxNuf3TLlPNxGd8zuhnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 15:06:45 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438%4]) with mapi id 15.20.6455.020; Wed, 14 Jun 2023
 15:06:45 +0000
Message-ID: <cd4fc492-074f-290f-81ac-cb65715c51b0@amd.com>
Date:   Wed, 14 Jun 2023 11:06:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, muralidhara.mk@amd.com,
        joao.m.martins@oracle.com, william.roche@oracle.com,
        boris.ostrovsky@oracle.com, john.allen@amd.com,
        baolin.wang@linux.alibaba.com
Subject: Re: [PATCH 1/3] x86/MCE/AMD: Split amd_mce_is_memory_error()
To:     Shuai Xue <xueshuai@linux.alibaba.com>, linux-edac@vger.kernel.org
References: <20230613141142.36801-1-yazen.ghannam@amd.com>
 <20230613141142.36801-2-yazen.ghannam@amd.com>
 <9d0adc21-5b71-a949-fc6d-95dd7ef6f0a7@linux.alibaba.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <9d0adc21-5b71-a949-fc6d-95dd7ef6f0a7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:a03:331::8) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: efe94b14-a4e8-45fe-ddb7-08db6ce8f818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qg8PGLcnqO34qoBTBfsvUm31W//2UYTbJ4YSfmaPbFH65qdl536JtmNKFgefxsPeh5IgInOEAM2JquwOmUewUx8ULckvrQulf5iST77nNhsEDgz9F17WartyKsd4erXIusR55E1BvK57e4PI9+iNgmWpFs2nH1qE0tT1tBWRx9yUqWt3Qo56mgYRF/wRTXk0NfDET562lwTRd7jMaHddjxyZNFnLiW+/ZBvJJB8ORxkzTrZAj5+UZ/aBAYFwBuh3mX9FMZ1XKXzNQlJ3UTrifpqij0gotL2u8pUFZgNmPSAQoezmDVYV7f1iZ5xUcAyEp+zQsGEc/+dUuNzPCNAAjVDgaFhvNI/Fhl6zFM4Cv0P0JkYgmQ7tZU9jPxVLPGz4EgdEAhX1amBhwvNziuaJYrr/EPuKFBpbw8eu89vEg3uwqhYnEx8y9IeJ4ZWT5D1GeXtc7ueCpZ/FsSOy20tNu8iXT6zIQ5g6iGpGby0VSSJIBBPyukVDuOpfGqgNaMYdJWvOR3v0T11Rick02OmfM0trUxJHeeRRZ56RVYLFJrkUc7MLkYKDdPhM1/NH9ZLWgMbTQqUJ5qB7uijLEp5dSDNCW0rIY3C3XDFbcdGapn6ExXo6fZCWATu/5nDYJWb58xFE8ooEMtwl45GD2LKKAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(186003)(86362001)(26005)(6506007)(6512007)(53546011)(31696002)(6486002)(966005)(2616005)(31686004)(83380400001)(8936002)(8676002)(6666004)(5660300002)(478600001)(2906002)(36756003)(38100700002)(316002)(41300700001)(44832011)(66556008)(66476007)(66946007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c25tZ0dobTIvdnArK05wblA0Z3llaWhYaEl5TC85Z1JoRy84MThsQVRXNHky?=
 =?utf-8?B?cEJHQTRDUmpYTUd3LzdGYm5JelB3TTFCZnZLelRBWGdrbFZXVUVtT2NmbE1s?=
 =?utf-8?B?WDBoRldiTjBKQ1BwVHNVeTVHM1pHQkE5U1ZUbmJOZytXeTh0VkZ1SDQxU3dy?=
 =?utf-8?B?NGc5ZDlQL2ZVdVROT2NTRjYrUVAyWE5QVVgvZ1BZbWNUK3F2UzJKUFhlREdi?=
 =?utf-8?B?VU90ZzFpdXZ5UjQwbXk2NUxDOExvZ1o4QklHU0lkNWRTRHV5emFuQWdRNWdE?=
 =?utf-8?B?SDFKam0vUmtkMTVRK3pQSEpHOHJmbG1wczhwZ1R4T2hDODkzOFhXTkRKd3I0?=
 =?utf-8?B?R3cvUlVVcTNTU1VuYnFFTUFnYjc1Z1RiamttYkN3MWpSVFFzSGNQZFJLM00z?=
 =?utf-8?B?blhsbWd3bklObGlPQWdsYXJtb1FNSWszekZjTWYwdUdsVTljS0FucG9uT3Vq?=
 =?utf-8?B?Ykp1bFNxUXhQZ1p0Yyt5cjRIRGJlUG5XcmFvK1hDak1SRlFxOHNnNFdxejhY?=
 =?utf-8?B?WWs4ZTc4TTljTHdsVGRTR2E1ZU4xVFd3bWZCcTJWdXBSS1hNQW9HV2g2SUw2?=
 =?utf-8?B?Qkc5cmF4bFZuQXFCKytVd0xYTk5VZUQ5MWxWdWdMZFNDQjhiTHVTNkFqVjFy?=
 =?utf-8?B?NkJJSUV3RTkwUWlOeU5qWU5rQmRSeHVGQWI3K0tUN0RRUVBFMUw2cGFjY09m?=
 =?utf-8?B?blBqVVpDZVAyU3planBZcEtpZ0hEU05saUdXenI3N3MyWWp2NUZlYmxIb0hv?=
 =?utf-8?B?TlFWdURMeVJVRThaRk9wT1N2WjZYcCtETnJIcGR0eFNWQi9QL1lROWtYMThI?=
 =?utf-8?B?WGQrMHJxcVhMOGt2UHE5Qmhlb1B2Tmo2VUpBWW9pQTVoVlh4UURkak4xS1NB?=
 =?utf-8?B?T05Eb1d5UlQ3ajNrRCtTd2d3MnR6c08yNjdlRi9zd0hjdGdORE5jMnUzdGhs?=
 =?utf-8?B?aWRYMmRPN25KTkdlbVhLTEN4RXZvNzNSK2N6WnZhMnZHVXU2U2luS004N210?=
 =?utf-8?B?Q0FzRDQzZ25ValVES1ltV0RiTnhJR2RtRzhIS3RpRUE1TGZnQ0xUcWM0QTlj?=
 =?utf-8?B?aWlFb2VZTkFLMUFEWVJzaVZLWk9YREF3S20zQnBFZ3lVMVBkQkxRTEg0R0Ru?=
 =?utf-8?B?bGVNVjEwVHQ1M3EwdDEzTXBKcEFYalIzQVlndnBacnh3TEM0SlFqNWMwbUgv?=
 =?utf-8?B?RFNlb2pCMThWOHNuT1dBWkFGdzQxTGpFQ1pFVU1ScHArS21NdlNBU3Brd0VF?=
 =?utf-8?B?QTlvSk10RkEvOWJya053eVJIK0ZjNUMzMjJZbFJqbUxDU0hTZ1lvWnVHcFR6?=
 =?utf-8?B?aFFDMDdKdWV3a3dhNERYc0k0dHpaMXUxS1BZbFBBdm1wMU41c1lJUWxVRW5U?=
 =?utf-8?B?R2F0dU5UOVVmWWFJaVZqSGNqZEFDUnoramUvZmx5MHJrdktXZTFWdmtjdFpj?=
 =?utf-8?B?USs0RzUyU0I3Nm9UVkgvdDMwY3BWQzlkaThhYmZZcmpyS0tCNTRzMi9nS1J2?=
 =?utf-8?B?NkcxcFRNMXJmTUNkSDlNZjV0dERHMGlPMVdtRURqNEF4RGJSQUpDVWpnVitH?=
 =?utf-8?B?S1FHZ1ZWK0hlYWxSQnFlc1o2eWhra3ZRNVNLZ3JCT2pya09Xa2dkdlV6WGxT?=
 =?utf-8?B?TitPSFVBQ3BmQ1JCWkNrQkdvWWZ3TTIwd3FYSW50dStFcGtZamNTQzNXckF5?=
 =?utf-8?B?QURJVVBWTzY3OVdFTEorT1FGN1VvUDNSSmtHa3NNNTcveGs1VG40aG84VmJj?=
 =?utf-8?B?UjBUY0w2a211Wit1K2RwR0tpVDROQWpnR1IvRnhzYzl0ejdIcnJlMG5vRXJE?=
 =?utf-8?B?Vk5kREJhb2xad0hIWlJZckdZRCtleG0vRCtwMVBPTkEvN1M0NzVFalVCVEln?=
 =?utf-8?B?NmxpSlBEYTFqWTFSZDloYUx6VXp4SlZEYVhsMHNUOEQvQVpSM0pyV3JoaWsw?=
 =?utf-8?B?MEZFTVl4ei82WEtyblAyOXlWbUdaZUdhSERaUkZtQmF2aXJMMXpUdFU5cTcr?=
 =?utf-8?B?bG9EVC9LTmNuTmVGR1NLUzdxVkVMamlTd3B2S2FubW9zelYyeGJVVGlGbWdE?=
 =?utf-8?B?d3dnZDV1NUY0ai9nNm81ZS9LVnhhc2hhTUNYTHArYU9wckg1YTZOb1F5NW13?=
 =?utf-8?Q?FxhwHJiAuJT8fkG28PCPgHfCp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe94b14-a4e8-45fe-ddb7-08db6ce8f818
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 15:06:45.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHfx/FVvqFE2BMau0PBJjbD0KhH5hsDIwlQkFXIFJW3Sc1hB5HlAKLdgAWPPi86n82GOnFRRhuqNnXd6KMGVgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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

On 6/13/2023 10:06 PM, Shuai Xue wrote:
> 
> 
> On 2023/6/13 22:11, Yazen Ghannam wrote:
>> Define helper functions for legacy and SMCA systems in order to reuse
>> individual checks in later changes.
>>
>> Describe what each function is checking for, and correct the XEC bitmask
>> for SMCA.
>>
>> No functional change intended.
>>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>   arch/x86/kernel/cpu/mce/amd.c | 30 +++++++++++++++++++++++++-----
>>   1 file changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>> index 5e74610b39e7..1ccfb0c9257f 100644
>> --- a/arch/x86/kernel/cpu/mce/amd.c
>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>> @@ -713,17 +713,37 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
>>   		deferred_error_interrupt_enable(c);
>>   }
>>   
>> -bool amd_mce_is_memory_error(struct mce *m)
>> +/*
>> + * DRAM ECC errors are reported in the Northbridge (bank 4) with
>> + * Extended Error Code 8.
>> + */
>> +static bool legacy_mce_is_memory_error(struct mce *m)
>> +{
>> +	return m->bank == 4 && XEC(m->status, 0x1f) == 8;
>> +}
>> +
>> +/*
>> + * DRAM ECC errors are reported in Unified Memory Controllers with
>> + * Extended Error Code 0.
>> + */
>> +static bool smca_mce_is_memory_error(struct mce *m)
>>   {
>>   	enum smca_bank_types bank_type;
>> -	/* ErrCodeExt[20:16] */
>> -	u8 xec = (m->status >> 16) & 0x1f;
>> +
>> +	if (XEC(m->status, 0x3f))
>> +		return false;
>>   
>>   	bank_type = smca_get_bank_type(m->extcpu, m->bank);
>> +
>> +	return bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2;
>> +}
>> +
>> +bool amd_mce_is_memory_error(struct mce *m)
>> +{
>>   	if (mce_flags.smca)
>> -		return (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) && xec == 0x0;
>> +		return smca_mce_is_memory_error(m);
>>   
>> -	return m->bank == 4 && xec == 0x8;
>> +	return legacy_mce_is_memory_error(m);
>>   }
>>   
>>   static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
> 
> Hi, Yazen,
> 
> Which tree are you working on? This patch can not be applied to Linus master ?
> (commit b6dad5178ceaf23f369c3711062ce1f2afc33644)
> 

Hi Shuai,

I'm using tip/master as the base.
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/

Sorry, I forgot to mention this in the cover letter.

Thanks,
Yazen

