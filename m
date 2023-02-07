Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD52568E0DF
	for <lists+linux-edac@lfdr.de>; Tue,  7 Feb 2023 20:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjBGTIE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Feb 2023 14:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjBGTID (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 7 Feb 2023 14:08:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0572D48;
        Tue,  7 Feb 2023 11:08:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erOmHFTUYHrd7G6dNif9XmsSHXGpVfrCeanMmuYjdSAc8HRH+KTVD4kzcG4Hm4g9RZHwVaAE2JXNTxn8ekrnyokg3Lv6nn9yIlNXUw14r7h0MRl+NduKVoOgh8Qo7tE7qjTTFZwxRh0Y92xj8D/Ezx6+kCHc5QEjztrj+Ri/MeZDLsGCRcpc1ZsnPFP9xwkuzPjoXWpGfzbGsDI8HCSh7fRXUacxpy+wfQh4rjbzjpgk4GFVxrzngc+/rvo+ijKXdKqxVjPvI8VDrGOZph/jivyhHJApJwOCL3AXq7A/vmuAahrKy+nBV78alGV9DetZja3ee+Nj9MtIX+QTq86j0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9f6G5xPQCuMzrf+CXiNCEZvmiSYhSW98kT3Zj1mgSw=;
 b=dNPvQn4Qw6GNwKyV3uW5LeTK3VJtmKbP+gEV8c7okXUj7dR+eCfAaUfynFTndmW7GrWVq3Us4DVsDCVbAq8py4+yfVtwE8KpO+jBa1C+Nj0xlVsuSrqn8tmUhwmMt648xP49XC65o48evzpm/D+qNbX+oJ6AQzQLU/N8KjxvSmywFTe8Q++LgKssDY8ju0khkdVKhNn762POwQ83kqNbVxMO/huJIboi/u8ftNP3I2nBSqmpHQEE00bSjJLooFMPg0+7UCRWxDWisCsUUoUAUt9N1L/EClvrUC2pyJwGmaqQyyyLvCWpZiyyyO08hpsXcRjTWnjkKZjhcYsTAgp9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9f6G5xPQCuMzrf+CXiNCEZvmiSYhSW98kT3Zj1mgSw=;
 b=LIJ6VSXgLq4aKgVgNi0q+vEV2Odjw4Ph0HqNd0fIxEwm6P5LSAcUkrBs/gkJI398GnzIwndPrR6i2a+WeUIA7hIdOk/5Vb8JvkxD0rxTkeKLYYVLLS1F7rqKW21vYo8N+pTfm1j2zNqFexgXLFwdhZddn72uSd8unFnJMxlswDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 19:07:58 +0000
Received: from CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::1cb2:1db0:4e6a:7b25]) by CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::1cb2:1db0:4e6a:7b25%2]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 19:07:58 +0000
Message-ID: <04027deb-71f0-ae2e-029d-d35f307d6d80@amd.com>
Date:   Tue, 7 Feb 2023 13:07:55 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH v1 3/3] x86/MCE/AMD: Handle reassigned bit definitions for CS
 SMCA
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
        yazen.ghannam@amd.com
References: <20230116191102.4226-1-avadnaik@amd.com>
 <20230116191102.4226-4-avadnaik@amd.com> <Y8Zo+hj8qxYpZdAl@gmail.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <Y8Zo+hj8qxYpZdAl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:32b::19) To CY5PR12MB6203.namprd12.prod.outlook.com
 (2603:10b6:930:24::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6203:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: f1949222-7f5c-4353-ee2c-08db093ea01c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PdLeDW7TTkWRmWkXO41dKCggOXxs+sHw7wWf5l/eXT3IshShaFcLUObB38pXrwi+WlJYakpCmItAjzhBRMB+tNHEAVp7menhYE+bhyLjFVhlGSMwlfbS5XE51pg8AV5xkd9BjB69TUSYsl28kHKKfXUzwsJjAQu7b2C9J2kKq0Sr4JHNl9/GIabnQakRAFLb653e+HBBbdrOdJFUq8OMDRZgkYW+iJHQHlbdQ/qt1K2wQeLhVcAqf7xeF+03pQ/ANZIhDn3FaxnkuTo2eFRcolItV66A/GVPy1bmnkyrdAdleXTEHgThOYbE92tPv5eegePClfny6W7qRg/LnsZE9ki7FM8Ofp0BSxsK+xdFr3cBRV1JT6Ekcw+ONXLwxyPWzhDtYZyqZKVrgWdM2We1SqEoH0oAzoKNO5ezulLNCcpOHn2jzw9zAfwRvL+hGpgyCoj3BkbL3EPggnqvuByaapuwn6TTxYzo5E8OtOcWOoAWW8aDlRvBUs7ZEvyfRc/X55/LKAxf1oHwro/xNZ8XZuWw5zfX2AYCuICamf3JYumqIKZURrAwVKrk/Da/3PXdC4KCGfK6HE/SbaWvuZSr0tH2ebJETKCI6MTFiqMMqqN6J9LsSCOIALzVfch06LLsysNA2p7eXT+/nCl9LdB736fQcmP75HADowAx4kowdH4Lg+WXFhZMdRP/d9TYPPAO3WYWIKG8t8uyk3eZN0t6zPGtNgWaVkWKkfgCk8rpME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6203.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199018)(31686004)(38100700002)(36756003)(53546011)(6506007)(6666004)(6512007)(186003)(26005)(6486002)(2616005)(83380400001)(4326008)(66946007)(66556008)(316002)(6916009)(8676002)(66476007)(31696002)(478600001)(5660300002)(2906002)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUdaMEtxaDVPWWtXeFA0Z3lxMGpqalM3ak94Zkw3LzdqMmV0ZkthVGxXRGkz?=
 =?utf-8?B?b2J5QisrS2oza014MURLeW4zUU1YekNXQTRmME5UZ1R0eEk2SW43NnFydUEr?=
 =?utf-8?B?TWRGcFFmaHc3OTIxS2VweHhZVUpaZnFuZFh6QkZlVW9UZHcyeHp0US9yUWsy?=
 =?utf-8?B?cGZsSHQzbkk3bDljR1dPK2sxT012WjE5TnRWYWV1SHJRLzF0WWNFRWd3RURt?=
 =?utf-8?B?eDRkQ1BLZG5VTEVXU0RaZHRwcXhTbjMvcmxjTXFsUW5XZTBFaS9GVGtTc3Rq?=
 =?utf-8?B?bURTbGRObWlQNVkvM2RXUjcxdWlzQWF4azFIT1lwZkxMc01Xekp1SkxJWDRV?=
 =?utf-8?B?cnc3QkZNK1VhRExyT0RXbk4zeFo2c3NsdU5OOFFraDFaMjAxajUvc0Y4MVB3?=
 =?utf-8?B?U1RYdGFqalRuMjN1dDZpbWpNL2pOcCt1Q0FjL3ZJbnNHZkJlbTFHS0t6cWc1?=
 =?utf-8?B?L3U0RUdqbHhrZHNqQWY1bDZFdlJDeEZNMWdsS1g4cHN3Qmg5Mkl1WW5seThk?=
 =?utf-8?B?WU1oWk82aXBNVWkyL2V6WG9VU1BJWC9JcHJLVW1UcUNTK2dFY1d5b0lDUVJP?=
 =?utf-8?B?aHl0RVVyeStYaUlSakozVWQ2TzZvanl5SlZiOHAyamduemlQdUdjc0pjRWYw?=
 =?utf-8?B?N2NiaHhkVm1CaldHbnc0SWY0am5YSGxRTERIMjV0T0hXZHR3TTlRMm15bnl6?=
 =?utf-8?B?cEZubHczVnRocmxpaGZRN0tnUm41N2tmK25ISmJFVDdlUUQ0RktzaW12SzZZ?=
 =?utf-8?B?cnZYa0RtY1ZNa25UVW1nUlJ2SVJ4VTdsYUlHM2tqNThHWTJtT2YybWFrcTJD?=
 =?utf-8?B?c1FEMDFieEJBZEZCWmYza2lIditKbktGWXd2cUhaQWFsa3NoOTdzTzdWMFB1?=
 =?utf-8?B?WWl2RTAwRG1SMk5uK01QbWZLVnEzbFpvNTVHK28wQy8wZW1TUkpDdGlxQ3c2?=
 =?utf-8?B?OW5WcGpXNXJMcm1aWUhiSXJCS1dScHA2R0lETWNHc2QrQkl4a0xJSXl6WWZO?=
 =?utf-8?B?aUE0MjJTQ3dvL2w3d250dnZhMC9WMVU5cGlFd3VZcitxRTlES0xzaU5aaWhy?=
 =?utf-8?B?Wjdla3hXUWhaNHhCNm9za1ZRcXVGbUxhZkRXOFlRNldydkRoRGNjMVM3L3Ar?=
 =?utf-8?B?U3U3M2JwSHROYVVBbkMzK05ybEVOd0I5c3JPdytNdkxENFExVWt4YWtHOEl0?=
 =?utf-8?B?Q2UxWkZ1akJGTW9Cb0Q1a1lzYjlxd09TeUtyUFlWMllYZlBTRDlnSmdxWmIr?=
 =?utf-8?B?NEIrOUhCYzVQWVJTTGdwMEJZKzNNNUJFcGp3Z1hQdTFXaktJVVh6NWpyV2JQ?=
 =?utf-8?B?S2s2dDgxaXpaUElqd0JGU29IL0NPenBlVFErL2U0TXUvK3NGUnJETlBWMS9D?=
 =?utf-8?B?TUg1NkJreVZ6bE5rMUFhZHNrVkgyNkFJR01HcG15cHd3M084OTlweWdtSk5l?=
 =?utf-8?B?U0I0VUpOajVENFZWWlUrdDYycE1ubm11dWFQbFYrYkd4aThHWTFrY0Q5c21x?=
 =?utf-8?B?QURkZm9BMGZTNFZybmRnR2xDMlN4VjQzQ0gxSUxWbU5NdkxpTFF1ZERrQ0JM?=
 =?utf-8?B?RkFyUzZRV1M2dStESWM5NkdmVUROZ3dQakRJQkNrYkxJZi91ZDAwQUcwZ0xD?=
 =?utf-8?B?TmIvOU84QjhEakQxcFJqVXNQeExNdTFiRlZ3UUorMW03bFRwQmtKQSt6ZjlQ?=
 =?utf-8?B?TXBQZDVodTM1R0pjZWR5RWpNQzhEaEhRZDM0b2llQ3FHVEw3OXkwWVlCa0pz?=
 =?utf-8?B?WitLRTFjb1IzUStnWE1zd3hCRjAvOWFGdU9naTdBanVHeXpCdjNJZCtzNDBB?=
 =?utf-8?B?QjVaQVFOQ2ZETU9rM1VIdFpkRFBVYTZLQ2phZkJWYUhTUnNVRGYwWTNoWGda?=
 =?utf-8?B?a2pId0c3MVU1YUZUOUxoOEdXWjhTMHRWcEk2dm1hTko5N0syNmkzTFVBYUlF?=
 =?utf-8?B?dTNDOVEzcEUwUkZLenozTW5FUG5leFJtWDZCM3NwU0M2Tjl3cVFFZ2FwOHdv?=
 =?utf-8?B?TGhOZUgxZDVETURIdFhEcE5nZGhXTEpVTW1WREZNYUw5ZjZqMkQvMjhQWTZv?=
 =?utf-8?B?SHM5RTBzSzc3enBnOE0yZG1vRFFkclhsMTAxd3MvVzZkTWNTd2tLZWZaUWRM?=
 =?utf-8?Q?/L5F1QPfDxT8GRVDuBlFw1B3V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1949222-7f5c-4353-ee2c-08db093ea01c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6203.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 19:07:58.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PziebPXqUyQYuHv1BsIf3HBKjpzmsJlYDwomCEU0K1MtbJ/NUhA3CSVFlLL1/6+l5F32lRblzdjeJzr5YChXvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On 1/17/2023 03:23, Ingo Molnar wrote:
> 
> * Avadhut Naik <avadnaik@amd.com> wrote:
> 
>> @@ -178,6 +178,8 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
>>  	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
>>  	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1)	},
>>  	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2)	},
>> +	/* Software defined SMCA bank type to handle erratum 1384*/
>> +	{ SMCA_CS_V2_QUIRK, HWID_MCATYPE(0x0, 0x1)  },
>>  
>>  	/* Unified Memory Controller MCA type */
>>  	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
>> @@ -259,6 +261,17 @@ static inline void fixup_hwid(unsigned int *hwid_mcatype)
>>  
>>  	if (c->x86 == 0x19) {
>>  		switch (c->x86_model) {
>> +		/*
>> +		 * Per Genoa's revision guide, erratum 1384, some SMCA Extended
>> +		 * Error Codes and SMCA Control bits are incorrect for SMCA CS
>> +		 * bank type.
>> +		 */
>> +		case 0x10 ... 0x1F:
>> +		case 0x60 ... 0x7B:
>> +		case 0xA0 ... 0xAF:
>> +			if (*hwid_mcatype == HWID_MCATYPE(0x2E, 0x2))
>> +				*hwid_mcatype = HWID_MCATYPE(0x0, 0x1);
> 
> Why are we open-coding these types?
> 
> Why not use smca_hwid_mcatypes[SMCA_CS_V2], etc.?

If I understood correctly (And please rectify me if I didn't), did you mean using something like the below snippet instead of what I have used?

if (*hwid_mcatype == smca_hwid_mcatypes[SMCA_CS_V2].hwid_mcatype)
	*hwid_mcatype = smca_hwid_mcatypes[SMCA_CS_V2_QUIRK].hwid_mcatype;

If yes, then SMCA_CS_V2, SMCA_CS_V2_QUIRK etc. originate from the enum smca_bank_types in arch/x86/include/asm/mce.h.
As the enum stands now, it cannot be used for indexing into the smca_hwid_mcatypes array since it might result in incorrect indexing.

Please advise.

Thanks,
Avadhut Naik
> 
>> +			if (*hwid_mcatype == HWID_MCATYPE(0x2E, 0x2))
>> +				*hwid_mcatype = HWID_MCATYPE(0x0, 0x1);
> 
> Ditto.
> 
> Thanks,
> 
> 	Ingo
