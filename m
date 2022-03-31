Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CC4EDBD9
	for <lists+linux-edac@lfdr.de>; Thu, 31 Mar 2022 16:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiCaOnf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Mar 2022 10:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiCaOne (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 31 Mar 2022 10:43:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8D21591F;
        Thu, 31 Mar 2022 07:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEqPen5EQov8LDfzeAKkZgDUBhz7c+fVLgg76D6EBxamksRvUeAbBzjAljkgNgsveQQcfi7ibnoSBZwjoiReJNQQPfrOp72tTzSEaDZ9OQJKimPyqQ34EJefelv9qKonE1b0Bd+oExZGsxIosxAeOGcRfhCifuFswDHiRSJ/v2ra70ZBNRCf4bmdoJZBVPkwD9fjIHaTmZOjBEHRan0PApPgm4oiqMnJzRDpdXfS01IUN3SPMJhn2KR0NIdyd249uzIGRryiil3wcuLHsWWHz1aQEV4Dcwh9HxTNppUeVGU0V3EkcxECdBt7GLB1SNq1bS8CYnv0sTHcEgWd/8EiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4ktsIOAnxc/MwXYDBvFeM5OFU+IWOdoeqxy3b+FVEM=;
 b=c555ntPJjgEBrzh2tzx33QUaAvdcW6CDqvA2OGcrAHdVdcCLU6K0E/aTQr8dAs4S/GSHtVsPZTsWLOP6I9WvlN8E9psGcnGkk5s4yxAgb5qk3fmi1dMuhUJoLxlYwUyEMRKqrqfYVL1ie9S1xVHa9x6vesWqt/O/LFqRIy/yiyyNOtCS+F0aJv3Ctg/pbfIgt2jIgQosaSeMZsDlihgazit4FBi/ztxAsWrcZaO1tWEkIiJPuQ7v4/vvBnC6UykqctWbZIV28yK9kApN2Nbh/rviAoIybPWNy1E2EyasPt+AC3IfyXM+2MwwJpfvaARUfLHA2bG+eFS2W09D/TMWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4ktsIOAnxc/MwXYDBvFeM5OFU+IWOdoeqxy3b+FVEM=;
 b=nUuDfZh6QRwkI2BnnbwF28KSAaD/UxG9ymAaqSCzKFJWDkxmNd5cJShZWp0LxO3ldGJe2BKPfqteZZAztvwCQD3+0XlTQEoES1qXt+CfQSu2Xlkjeq62iHDmTrzSXZkC/ARl6C00iH23iim5QM1Jr9Jrib22GDxlGX7tHdDxFWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 14:41:43 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f%6]) with mapi id 15.20.5102.022; Thu, 31 Mar 2022
 14:41:41 +0000
Message-ID: <5096b443-1c76-7e74-f596-e994800d7d2b@amd.com>
Date:   Thu, 31 Mar 2022 09:41:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] x86/mce: Extend AMD severity grading function with
 new types of errors
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
References: <20220328134131.736572-1-carlos.bilbao@amd.com>
 <20220328134131.736572-2-carlos.bilbao@amd.com> <YkS3OYMrWJEyZsnb@yaz-ubuntu>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <YkS3OYMrWJEyZsnb@yaz-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:207:3c::47) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a1c0076-6794-485a-e892-08da132491e2
X-MS-TrafficTypeDiagnostic: SN1PR12MB2365:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2365A807A4ECC75B9A947EEFF8E19@SN1PR12MB2365.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SvaYBweopj3cglOXZDg8eJBX4qx9Q1iMiE3pG0h/+YP076CY315/kcawl6z2lqKtB7l21WA4p+hatdQEvHwkuHkj9wllFR/iokrHuyQ31BEAsCsNuiRauHvYnA//ascTGmgxDybj1wQMAlFPso/gOw3GntlO+2xDJ+KgcUqHrTzgKrI1+03CoK1BUIf7r7NqBzwVdTGd1gXWjPZPNdFIrruIgIvYSmP8fup/ZHxq/xVF7hYVC1sqy7CynJJpsEw4w1DwvpYdIYqZSWYMdCQHhtSUH+byJRnsWcgyNvaToasCExbWn7buDyge5wM4NrU8th/KLAs5zbU2dOUnnYTbn80txUwli0ziA4kNyYwg6XZO2ilzTLCeQeRFsQAKnTPaZcQDQgZTe7GgiGehPDpwcxI+SB/irePl6dKr6oKg/zoQZOc4ukZMEgz64kagFN7OlUIRjzbKx7It40RtlcQJ8pYocmaOhOMfX3FS2drjEfEekutKWQAN+XxvZaUQi8yxFAYYfPHGqas5F0MSP+x2bMhrgblYiqi13UlcQ9r+hLvsAgfG/VLjfA3h4leN+mTq8rgWxy8/VceiAwI5pTeFCaKsiqxLHAfe/zjAR4HwtMRRM5u+XNLf2J34qiJnYxPfEjchbEwG/O/hDgosxig23sp7sI0mihfmSpHuU4waix6IlB3795MsRI2hku6BrtKYr/0o1cEnNfMwIIbEbIWE2RDxE1jDg+v1Q+iuHnoCnW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6486002)(5660300002)(83380400001)(30864003)(36756003)(44832011)(31686004)(2906002)(6512007)(53546011)(6506007)(37006003)(66556008)(66476007)(31696002)(86362001)(38100700002)(6862004)(6636002)(2616005)(186003)(26005)(316002)(4326008)(8676002)(8936002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTdCU1hxYW1VYlhwVVNpOVRIeUFtaGNIVkpKc2Z3RDhQbEsyTjBwWUNYWE1I?=
 =?utf-8?B?R1dYeFFqcHNwdzFINEMvT0NUcWp0WjlSUGVOc2ttWml1RFc3TjN1U3BxWTMz?=
 =?utf-8?B?b2wwc1NuRzA1a09HTmNta2ZLcUQ5ZXlJa2ltK1F0S3VjTkRHL3VGcjhFdGs4?=
 =?utf-8?B?L0ZhazlmZWhXL21hN2tEZzB2S3Y3eUhFVm03YkNMdG0yOFRVUVFzcVI1RWgv?=
 =?utf-8?B?NzBZZFNuNkdwTVRyZUx1RG91dUU5d3QzOUxRYTRNYkNHQWl1S0pTQmNkMEtE?=
 =?utf-8?B?YXFlYmgrSUxYRXZlNE9oY0s2dVlHUC92WE5MZmxqaWc3VXZLTU13cjhxaU1m?=
 =?utf-8?B?SkZiNk0zeDIxNDZpUGFxQ2pubTV4M0VVSHp2d1ZmbEYrZzBiMStEaEpnZVpo?=
 =?utf-8?B?RDd4azZCcCtMQ21jMityMm5YTktDVXlDL05hZGRZaHdUV2YrNm9WWUNhYitB?=
 =?utf-8?B?b2hrQ2o1a3FJYmNDRFdmTHlGT0FBT0g4TDBhQzNvNTdMSStaazlXRUVRYkxn?=
 =?utf-8?B?Tm5ZdE9NREE5VFBBQWo2STdrMTNiaGtGeWRYY2VTR29kMmNHNEpYQUFhcThD?=
 =?utf-8?B?L2lWcnNWWTBsdGI1VXhKRzB6K21jL2w1Y3dRSnRCa01lS0xneGFhMjY2UDk4?=
 =?utf-8?B?V1Y1WThqWnI1U3RJVnlkOU1HdERkSjJlV3hsQ3VBc0NyTE9jek5sL2pWY3R4?=
 =?utf-8?B?ajY4b2hiM2xQdDh0YXhZcm5CQTI5dWNkNUowQkt4WVp2b2Y0Q3hJeTBzUERY?=
 =?utf-8?B?bVVCS1lNc2RsTXFyVlBnZHdWUWxCS0xOTW0rSDhWKytxVjVOQWlkcmp6Q0Nl?=
 =?utf-8?B?UmdRaURvVjdNN29WeDFxcS9Sb28zdXdCYmFuT1hadUxRU0dvK3M2Z3M3RGhV?=
 =?utf-8?B?U29GWVNHT2NxZWR1bWtZd2ZXb1lsNVFtZ2tqb2hqbm5DQjVJdmY4ZGxMRnAv?=
 =?utf-8?B?ajRaeFRmSDBjeXpRTnd0MStPL3VtVy8zZ1pYRis0RWJsb3Jma21Kd2xCdkxC?=
 =?utf-8?B?U1lUVmZVbU50cGZhcjJBODQ2bkxKSVZROExReDFZL1l2ZVZnaHNNMVJQVTBW?=
 =?utf-8?B?OEE4VXk5Tzl6QjVEcmdJS09ybWpieTF5TjJZRDcycU5YM0lIWnVac2tKUzVi?=
 =?utf-8?B?ank3Y2RxWEk1T3phMzRQMmhGZStwNDBZVDdxTlZYUVpadC9VdzdHb3M5ZG8v?=
 =?utf-8?B?S2tTa3N5dnAyZ0pHMytIK2ROZGIwVzk2NXJiVDcrYWYwN1BCUnEvazJWL0Jp?=
 =?utf-8?B?RWtSU2pHSlJiN3Rmb0EyWTBra3VJelg0b0xyTVZNbjUvZk5YZDhuVGZscWp6?=
 =?utf-8?B?ekt1TUFVdS9xd2UyT1ZibUJ6R1ZEOGVkaHhEVDdidnkzU2xoMHkzc3VsTHZy?=
 =?utf-8?B?dWpFcWVWMFZpdFlkUjZvNnAwVFFaaldiQUljK2I5M1dIb1k0M01zY0VveWJ3?=
 =?utf-8?B?aVRJbUMzWEhlK1d4Uzl2Mjh0cWVnVVZsUzdIWHFqbDVPd1BISm5nMEIvYi81?=
 =?utf-8?B?azREeUdLVHpWYVhQNXJOaU0xTkllNjJXa1cxaVgxRnUwQjcyd213eERscEl6?=
 =?utf-8?B?NFlrUVlDSTNzRVVhek80VFB5K3JIWXNWbzhGSWV6UC9jdVViS0RLVExZTGtI?=
 =?utf-8?B?bEhLVFMwN2NBVktYSHFMRkVvN2VnZ2Q0NUxnVW5wd04yQzhFOXpPSEkxM0w0?=
 =?utf-8?B?c1owM09PbUxyb0M0QWEyNmY5V1BSNExpOHdHV0M4T0E5aTZnZ3NIU2c5L1FU?=
 =?utf-8?B?VHJka3FGUnNkM2JrdE41UE5WbXdHSGZKNXFLNnZRMWcyN29pdTFiQzFNK3ph?=
 =?utf-8?B?UzNDSW9Ya0U5ZFNTNTlnQmpFa3QwRC9kVk5KOC92cGNiNDlrKzMrQk5tVVVT?=
 =?utf-8?B?UzltSERPSjJ5QWo5Y2FmQ3JLQ2Z4aTNSUzQ5Q3BKYVN3QUZFZ3FqU0ZKNGpB?=
 =?utf-8?B?akphd2NUWVE3VHdzenQxbmowT1UyWWVhWmp6RUtudFpoeVJJYk0rZG90Mjdr?=
 =?utf-8?B?eTl6RnI1QW1aR3NFTms1WXlTSlp2Vjd3YXdlSUVYeERYR0FsNXBVK2Z6TVZy?=
 =?utf-8?B?bmdGSWZYUWIwcVNkYSt2cTBpRmZ2MWFscjh0ZG9GdzltTmNScDdEL3Q0RWMw?=
 =?utf-8?B?Y3dLZlc1OXROMElXK1JWUEJHK3ltUTlnbjVkQzBlMng2T3R0SWpIQlIrbm9n?=
 =?utf-8?B?dmlGMVhlOEVocmk0YWxxbnArbkhzblIycnFOd2kxVnNrNGs2UDhkUi9iV1dB?=
 =?utf-8?B?d2tHYXJWeHg0NlpYcGE4bytVcDl4MGtZNXExQnNOUUkzejdDZzRtRUVyZytK?=
 =?utf-8?B?UEphbDI3ZGNyUjdsa2wwMmdxc3JxaWJCM0NzdVZPZjlkeDZoalV1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1c0076-6794-485a-e892-08da132491e2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 14:41:41.5069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYKue+rUB6GVmO+Nz+L9tpENy8V2rtU1tGMnV5iaqvhDoEMjl7ig3qKE2vTyFOhKdAxi0gPSjbhidetDG9KDXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/30/2022 3:02 PM, Yazen Ghannam wrote:
> On Mon, Mar 28, 2022 at 08:41:32AM -0500, Carlos Bilbao wrote:
>> The MCE handler needs to understand the severity of the machine errors to
>> act accordingly. In the case of AMD, very few errors are covered in the
>> grading logic.
>>
>> Extend the MCEs severity grading of AMD to cover new types of machine
>> errors.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  arch/x86/include/asm/mce.h         |   6 +
>>  arch/x86/kernel/cpu/mce/severity.c | 180 +++++++++++++++++++++++------
>>  2 files changed, 150 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
>> index cc73061e7255..6b1ef40f8580 100644
>> --- a/arch/x86/include/asm/mce.h
>> +++ b/arch/x86/include/asm/mce.h
>> @@ -50,6 +50,12 @@
>>  #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
>>  #define MCI_STATUS_SCRUB	BIT_ULL(40)  /* Error detected during scrub operation */
>>  
>> +/* AMD Error codes from PPR(s) section 3.1 Machine Check Architecture */
>> +#define ERRORCODE_T_MSK GENMASK(3, 2) /* Mask for transaction type bits */
>> +#define ERRORCODE_M_MSK GENMASK(7, 4) /* Mask for memory transaction type */
>> +#define ERRORCODE_T_DATA  0x4  /* Transaction type of error is Data */
>> +#define ERRORCODE_M_FETCH 0x50 /* Memory transaction type of error is Instruction Fetch */
>> +
>>  /*
>>   * McaX field if set indicates a given bank supports MCA extensions:
>>   *  - Deferred error interrupt type is specifiable by bank.
>> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
>> index 1add86935349..4a089e9dbbaf 100644
>> --- a/arch/x86/kernel/cpu/mce/severity.c
>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>> @@ -327,59 +327,167 @@ static __always_inline int mce_severity_amd_smca(struct mce *m, enum context err
>>  }
>>  
>>  /*
>> - * See AMD Error Scope Hierarchy table in a newer BKDG. For example
>> - * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
>> + * Evaluate the severity of an overflow error for AMD systems, dependent on
>> + * the recoverity features available.
>>   */
>> -static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
>> +static noinstr int mce_grade_overflow_amd(struct mce *m, enum context ctx)
>>  {
>> -	enum context ctx = error_context(m, regs);
>> +	int ret;
>>  
>> -	/* Processor Context Corrupt, no need to fumble too much, die! */
>> -	if (m->status & MCI_STATUS_PCC)
>> +	/*
>> +	 * On older systems where overflow_recov flag is not present, we
>> +	 * should simply panic if an error overflow occurs. If
>> +	 * overflow_recov flag is present and set, then software can try
>> +	 * to at least kill process to prolong system operation.
>> +	 */
>> +	if (mce_flags.overflow_recov) {
>> +		if (mce_flags.smca) {
>> +			ret = mce_severity_amd_smca(m, ctx);
>> +		} else {
>> +			/* kill current process */
>> +			ret = MCE_AR_SEVERITY;
>> +		}
>> +		return ret;
>> +	}
>> +
>> +	/* at least one error was not logged */
>> +	if (m->status & MCI_STATUS_OVER)
>>  		return MCE_PANIC_SEVERITY;
>>  
>> -	if (m->status & MCI_STATUS_UC) {
>> +	/*
>> +	 * For any other case, return MCE_UC_SEVERITY so that we log the
>> +	 * error and exit #MC handler.
>> +	 */
>> +	return MCE_UC_SEVERITY;
>> +}
>>  
>> -		if (ctx == IN_KERNEL)
>> -			return MCE_PANIC_SEVERITY;
>> +/*
>> + * See AMD PPR(s) section 3.1 Machine Check Architecture
>> + */
>> +static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
>> +{
>> +	enum context ctx = error_context(m, regs);
>> +	int ret;
>>  
>> -		/*
>> -		 * On older systems where overflow_recov flag is not present, we
>> -		 * should simply panic if an error overflow occurs. If
>> -		 * overflow_recov flag is present and set, then software can try
>> -		 * to at least kill process to prolong system operation.
>> -		 */
>> -		if (mce_flags.overflow_recov) {
>> -			if (mce_flags.smca)
>> -				return mce_severity_amd_smca(m, ctx);
>> +	/*
>> +	 * Default return values. The poll handler catches these and passes
>> +	 * responsibility of decoding them to EDAC
>> +	 */
>> +	ret = MCE_KEEP_SEVERITY;
>>  
>> -			/* kill current process */
>> -			return MCE_AR_SEVERITY;
>> -		} else {
>> -			/* at least one error was not logged */
>> -			if (m->status & MCI_STATUS_OVER)
>> -				return MCE_PANIC_SEVERITY;
>> +	/*
>> +	 * Evaluate the severity of deferred errors for AMD systems, for which only
>> +	 * scrub error is interesting to notify an action requirement.
>> +	 */
>> +	if (m->status & MCI_STATUS_DEFERRED) {
>> +		if (m->status & MCI_STATUS_SCRUB)
> 
> Multi-line if-else statements should have braces. This is true even for
> conditions with a single line. This is a coding style point.
> 
> In other words, if all conditions are a single line, then no braces needed.
> But if any of the conditions has multiple lines, then all conditions need
> braces.
> 
>> +			ret = MCE_AR_SEVERITY;
> 
> This is wrong. Action required is for errors that need to be handled
> immediately and where recovery is possible, like a poison consumption
> machine check exception.
> 
> Also, the SCRUB indicator does not contribute any new or interesting
> information in terms of OS actions.
> 
>> +		else {
>> +			/*
>> +			 * deferred error: poll handler catches these and adds to mce_ring so
>> +			 * memory-failure can take recovery actions.
>> +			 */
>> +			ret = MCE_DEFERRED_SEVERITY;
>>  		}
>> +		goto amd_severity;
>> +	}
>>  
>> -		/*
>> -		 * For any other case, return MCE_UC_SEVERITY so that we log the
>> -		 * error and exit #MC handler.
>> -		 */
>> -		return MCE_UC_SEVERITY;
>> +	/* If the UC bit is not set, the error has been corrected */
>> +	if (!(m->status & MCI_STATUS_UC)) {
>> +		ret = MCE_KEEP_SEVERITY;
>> +		goto amd_severity;
>>  	}
>>  
>>  	/*
>> -	 * deferred error: poll handler catches these and adds to mce_ring so
>> -	 * memory-failure can take recovery actions.
>> +	 * Evaluate the severity of memory poison for AMD systems,
>> +	 * depending on the context in which the MCE happened.
>>  	 */
>> -	if (m->status & MCI_STATUS_DEFERRED)
>> -		return MCE_DEFERRED_SEVERITY;
>> +	if (m->status & MCI_STATUS_POISON) {
>> +		switch (ctx) {
>> +		case IN_USER:
>> +			ret = MCE_AR_SEVERITY;
>> +			break;
>> +		case IN_KERNEL_RECOV:
>> +#ifdef CONFIG_MEMORY_FAILURE
>> +			ret = MCE_AR_SEVERITY;
>> +#else
>> +			ret = MCE_PANIC_SEVERITY;
>> +#endif
>> +			break;
>> +		case IN_KERNEL:
>> +			ret = MCE_PANIC_SEVERITY;
>> +			break;
> 
> Is this case needed if it's identical to the default?
> 
>> +		default:
>> +			ret = MCE_PANIC_SEVERITY;
>> +		}
>> +
>> +		goto amd_severity;
>> +	}
>> +
>> +	/* Processor Context Corrupt, no need to fumble too much, die! */
>> +	if (m->status & MCI_STATUS_PCC) {
>> +		ret = MCE_PANIC_SEVERITY;
>> +		goto amd_severity;
>> +	}
> 
> This should be the first condition checked.
> 
>>  
>>  	/*
>> -	 * corrected error: poll handler catches these and passes responsibility
>> -	 * of decoding the error to EDAC
>> +	 * Evaluate the severity of data load error for AMD systems,
>> +	 * depending on the context in which the MCE happened.
>>  	 */
>> -	return MCE_KEEP_SEVERITY;
>> +	if ((m->status & ERRORCODE_T_MSK) == ERRORCODE_T_DATA) {
> 
> This information is not useful for determining severity.
> 
>> +		switch (ctx) {
>> +		case IN_USER:
>> +		case IN_KERNEL_RECOV:
>> +			ret = MCE_AR_SEVERITY;
>> +			break;
>> +		case IN_KERNEL:
>> +			ret = MCE_PANIC_SEVERITY;
>> +			break;
>> +		default:
>> +			ret = MCE_PANIC_SEVERITY;
>> +		}
>> +
>> +		goto amd_severity;
>> +	}
>> +
>> +
>> +	/*
>> +	 * Evaluate the severity of an instruction fetch error for AMD systems,
>> +	 * depending on the context in which the MCE happened.
>> +	 */
>> +	if ((m->status & ERRORCODE_M_MSK) == ERRORCODE_M_FETCH) {
> 
> This information is not useful for determining severity.
> 
>> +		switch (ctx) {
>> +		case IN_USER:
>> +			ret = MCE_AR_SEVERITY;
>> +			break;
>> +		case IN_KERNEL_RECOV:
>> +#ifdef CONFIG_MEMORY_FAILURE
>> +			ret = MCE_AR_SEVERITY;
>> +#else
>> +			ret = MCE_PANIC_SEVERITY;
>> +#endif
>> +			break;
>> +		case IN_KERNEL:
>> +			ret = MCE_PANIC_SEVERITY;
>> +			break;
>> +		default:
>> +			ret = MCE_PANIC_SEVERITY;
>> +		}
>> +
>> +		goto amd_severity;
>> +	}
>> +
>> +	if (m->status & MCI_STATUS_OVER) {
>> +		ret = mce_grade_overflow_amd(m, ctx);
>> +		goto amd_severity;
>> +	}
> 
> This condition should be checked earlier.
> 
>> +
>> +	if (ctx == IN_KERNEL)
>> +		ret = MCE_PANIC_SEVERITY;
> 
> This condition should be checked earlier. This would avoid the redundant
> checks above.
> 
> 
> Overall, the severity code should be audited and simplified first. Existing
> cases should then be updated with useful information like messages. Finally,
> new cases can be added if and only if they are unique, i.e. they're not
> already covered by existing cases.
> 
> The current code already follows the hardware documentation for the most part.
> Here's an example of how it can be simplified.
> 
> Pseudocode:
> 
> 	if "PCC bit set"
> 		PANIC
> 
> 	if "Deferred bit set"
> 		DEFERRED
> 
> 	if "UC bit not set"
> 		KEEP
> 
> 	if "Overflow recovery not supported" and "Overflow bit set"
> 		PANIC
> 
> 	if "MCA recovery (SUCCOR) not supported"
> 		PANIC
> 
> 	if "In kernel context"
> 		PANIC
> 
> 	else
> 		AR
> 
> 
> Notes:
> 
> 1) The Deferred and !UC cases are moved up compared to documentation. It
> looks like you had a similar idea. This saves an indentation level since all
> the following cases are for uncorrectable errors.
> 
> 2) The TCC check is not included. This is because TCC has a similar function
> to RIPV|EIPV *. And the only use is in conjunction with "kernel context". So
> this is redundant as "UC in kernel context" is a PANIC.
> 
> 	* A TCC check can be done as an alternative to mc_recoverable(). But
> 	  let's not worry about that now.
> 
> 3) There is no SMCA check. This is because SMCA is used only to determine if
> the TCC bit *may* be defined.
> 
> So please do the code simplification in a first patch. Then add messages for
> those existing cases in a second patch.
> 

Thanks Yazen, this approach definitely simplifies everything. I'll send a 
v2 of the patchset using this pseudocode.

> Thanks,
> Yazen

Cheers,
Carlos
