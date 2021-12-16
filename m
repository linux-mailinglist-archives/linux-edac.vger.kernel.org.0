Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEA4478079
	for <lists+linux-edac@lfdr.de>; Fri, 17 Dec 2021 00:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhLPXWT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Dec 2021 18:22:19 -0500
Received: from mail-mw2nam12on2134.outbound.protection.outlook.com ([40.107.244.134]:37344
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237176AbhLPXWT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Dec 2021 18:22:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbByXVUcqmysVZX9xh5tpKhNAWvhH36Sy0j1/5qFegmjKLvpfRpUDmHHwRf5Wt5X6BV0HG1D3gfhduHVm1tDoKbdHHwB30rlft8yhzC98sUw4ovXoxuZUFTZHpnSvHfElCUT7CafQRKNr8ufg+teWW5MAXsbAVTZN15UW613JMcvdpib4DMK6oE0DgoSOPJxImFECnS0Yh7P65BhsZsp90rf3i6swNJEMA4+58w1PPcnP+0lgA+G1taluNo8Fv9GT69op3jtODFVCqrHgKZAuWYBLA4lC2ILs8fzdsz+ipRMgiXsm7CYO6kYWOX43W4XajJL4IzmOuwa3g4pKP0xMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVnPSz/XHRBxqREpRYmQ22UO7jGpcXPtDreyNrYTPng=;
 b=a3+4cGgXtZ0og5ROCZhu0QKzi6Wz0ljoFsRKp6JTVwNlXFQ9IXJnVutN2MDKuLqYG18477eCjDqBi6HX9wSkT6jbD5BxrF/KWp7WA7joTBPXG/YfD43HnJ9KJoM69uD/U+mYUnVaVw/MeoKzvyCDGRwPB+il9egQ+WAox1dsNwouv5CQlkFYNIMXa2Rg0WdF1kHtA3gKTe50g2x45Imrepu1tfFoWQ7q0340pGcoXk3ZrxwBO6jadY/CeqKDcVuJN1BO668ImVnPiAQNdrfDdAaslMlApR0FFk0xPbGsrznqf7DesdXLAzXWnHp4kOd7isxNsF14PpWRxCoFiqLwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVnPSz/XHRBxqREpRYmQ22UO7jGpcXPtDreyNrYTPng=;
 b=wdq/Ib0CMZsqmZlKQyQKIQCTwcXRsE67EWjACYM1cJ+sGq++Twi6NT0/uXvM03HgH5Knt00L9QFQuQRm4o2jGkmbyoVz9bwFPuv1MJLm31ZCOQN9Yy7Wdv+R2ByjBVIh7X+tAAus0WjKRlpig3Q7UqWaa3OVOSpWB1sDAWflvG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from CH0PR01MB7033.prod.exchangelabs.com (2603:10b6:610:107::16) by
 CH0PR01MB7155.prod.exchangelabs.com (2603:10b6:610:f6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.15; Thu, 16 Dec 2021 23:22:05 +0000
Received: from CH0PR01MB7033.prod.exchangelabs.com
 ([fe80::c8fb:e830:d7e5:bdf7]) by CH0PR01MB7033.prod.exchangelabs.com
 ([fe80::c8fb:e830:d7e5:bdf7%9]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 23:22:05 +0000
Message-ID: <23813411-c14c-f83e-527e-98d9170874e3@amperemail.onmicrosoft.com>
Date:   Thu, 16 Dec 2021 18:22:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Tyler Baicar <baicar@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, abdulhamid@os.amperecomputing.com,
        darren@os.amperecomputing.com, catalin.marinas@arm.com,
        will@kernel.org, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, tabba@google.com, marcan@marcan.st,
        keescook@chromium.org, jthierry@redhat.com, masahiroy@kernel.org,
        samitolvanen@google.com, john.garry@huawei.com,
        daniel.lezcano@linaro.org, gor@linux.ibm.com,
        zhangshaokun@hisilicon.com, tmricht@linux.ibm.com,
        dchinner@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, ishii.shuuichir@fujitsu.com,
        Vineeth.Pillai@microsoft.com
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
 <20211124170708.3874-2-baicar@os.amperecomputing.com>
 <YZ6Jq39Z9dIUqcfO@lakrids>
From:   Tyler Baicar <baicar@amperemail.onmicrosoft.com>
In-Reply-To: <YZ6Jq39Z9dIUqcfO@lakrids>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:610:5b::12) To CH0PR01MB7033.prod.exchangelabs.com
 (2603:10b6:610:107::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c5c33cc-abff-420a-01d9-08d9c0eadf68
X-MS-TrafficTypeDiagnostic: CH0PR01MB7155:EE_
X-Microsoft-Antispam-PRVS: <CH0PR01MB7155641E7C612D9FDFCA076DE3779@CH0PR01MB7155.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2R0WFSSQDbT1YMzrhRK3/K1eosFN7HIaNYWlSPsSe4/FB3v2Xxz4h5fcP0f4LGytiE1meVZYWIKwlpRmofq0+Jq3GnaIWbCdIcM4KrpJkV1n7DqGRnJxIhiFaQ8z2iSL1ZxOsGVtm6ej0PgTjqramtX6og2z3JbAe2fjDB/F/8iN1F1lq+jHx9ryvuGTTtw3pg2AFVlwElM+5obywrGQaDe0Zuwu+D/j5fUTGsybCrGBlXyeHbGImdGqpqcOXka3kmCey6p4trgYub8QxhigTBbwNblFdQ8lExa0TwwdFoGX967TDw9yR7ZEeC8Bw9NKN3KZMXDyCv8kaupHuyfOtelhQD1lLuzLrIqIGfG1iHuCgZoxsLb/cGlu/G/gMkBTOlUBC60mEmkU3nR04ju1uZm3cCelyo1cR2Lvv3j3ugwSVsUbV/8GuBKBB1F1o2ddV7NSCVpaJ1SiwM5ToDGyNdBfGseOS1Bc9J5AkrGtkZqRlXMDQyzyNtxSyOjcArWyknsWT8+EkJiGWFBKKM3qAdUacqksjABXSauAzYv7dVxv6ksbgK2m6AOQKFTtb7SW8n1Ddi9eeYUZNbkNrwHi2qyU1pWZKeCGGfIo0poS+hzhsOw1HzhXKURcsgg6ZfHaI9BFK1/vtT70i+AnZHjw4u9Z/2CPbNHo1vKj+WT4kwzHN+hQ9ZSSewSjWL06ob5VkqAEvvAQ4891lpq153yXy5gDLEo8e5rFdTE0o0ZEivE7QW14UmzlIZYNu1z+fECJyLFH3VXFGCuDeOE7vN1wnBxBXiOcg0rgwQPKB1tILSZJAayxwcWaiXUNXxSupvcFGZ/9gb7ulz9goVMibeYCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7033.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(2616005)(8676002)(8936002)(66556008)(5660300002)(508600001)(110136005)(83170400001)(66946007)(31686004)(7416002)(26005)(6666004)(38350700002)(38100700002)(83380400001)(31696002)(30864003)(66476007)(316002)(186003)(6506007)(6512007)(6486002)(42882007)(2906002)(7406005)(53546011)(4326008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2xSa2drTHY3QTlrR2pidFFMUHhQYWZXTmVMR3I4R2FjSkdUUDBERzk5N3hM?=
 =?utf-8?B?TFZaangweDVQTjVaYWlsZDFubnV1QXYxTzRUS1dhZHExcXpnaC81OHZoOVhx?=
 =?utf-8?B?NG4wbUwzK0hZbFdqcDFBZ0FHTUJYd0pFR2lqWis1ODhrQ1pMQllJZ3J0YlpQ?=
 =?utf-8?B?Y3BpVmUyaU44TUJlelB4RFZJeEFHeXl4VVd3ZDBhN1pscnRvREtBdGtYUXJO?=
 =?utf-8?B?TkZlL2h2VkFzMEVUbEVZaXZ0K2hNV1hFV0Fwbkl5MjFEMklyZXhucklyeXpS?=
 =?utf-8?B?ejFBdGR4VnhGVTQrSjdCVXpPSG1pNTZhcTJ6Nk5LY3FkUnlyMHhpa05JRkM0?=
 =?utf-8?B?VHY0UWlTRUxlREZ5REtvYTI3Z0JUamsyeTNhZkx0cU5MR0ZWamIyZVRYQVB5?=
 =?utf-8?B?eHdWTGZKcUFrVG9VcHlqYWxUbXZlQzJYQ1ZjRHdlUnE2QUFIeXZLS01QUzNp?=
 =?utf-8?B?ZC8xTkFoUjNCRndzNFMxWnZJNUsycU52WGt2eGVVM3ZPQm5HTzZiUTdDbHFK?=
 =?utf-8?B?Wk5hcDRVL0l3Q3FzMGJ4MlNLUEFQN1ZhTHJERDdqS0R4QUxvZXVhcE95Zkxh?=
 =?utf-8?B?RXNVa2N4SWNNVFhVcVlsUE1KbWpEUzRsekg5U0RhNWNiaDdJTkkwa0N2NHNJ?=
 =?utf-8?B?SFBVK0dHSytQRHErakdoNU9xdWJZbm9MRWsyeTdjeittcGZ0NHhXREt1VGRJ?=
 =?utf-8?B?VFhzTjE4dncvblVJWkM4Ni9Oclo4eG9qWGl6VUZvS2lSK1hXejNSK0xXVlp1?=
 =?utf-8?B?SzFsZUlsSFBPOTIyRmsxUjl1eURrbzBWUysveFozemh3NVpWdi9reFFVZENM?=
 =?utf-8?B?dHp1ZndBaVA1UlBBUWxYcDdISjlIU3Q5NzJ3ZkRnSStEbTNqeXNyNjVabkhN?=
 =?utf-8?B?SWhqWkt6UjhHdjRPK1AzTE8rSkUyLzRPTWp3dGlab2x3dm9qNUw5U3BMTHps?=
 =?utf-8?B?NGg0N0tMdDZrdkk4MzFuTEVzZWZ5Z3JRNWJWczdFWk8veW9mT29scTNLMHBp?=
 =?utf-8?B?YTE4Y2RENVRTeXEyRzkyTkU5UWkxc3Y0ckpYK0l0cE11S3BEVnVhbnQ3OTF0?=
 =?utf-8?B?YVE4bWxEOStmV3R2bGI3dEpCYURlTXN4Q1NPOUZDaUVBWmI3Vm93MkJpWkVD?=
 =?utf-8?B?MllnYjJJNVIxNnNNWTVqRi85cUNXa3FVVk1aTjR1MkRLTTA0R2pvMlFtS0Vu?=
 =?utf-8?B?K0thcjlLbm1JK2VubGoxZTRlNGdiRWxBRlhsdFRXY1owZ0xmVmZ2czBzYlVt?=
 =?utf-8?B?SmJ2R1k0dXBpWkJDSjhMc2FlVWNWMFcwNFYyalpLQ0htaXVJRlZETEw0Uk8z?=
 =?utf-8?B?VlRLWUFiK1RURzU3dFltMktpV3BseWtibitqbzdZTk94Tk1IUVd3SklCcm53?=
 =?utf-8?B?ME1qdnF1QzcwMVFWNUxtYzdMQ20wUWpOY1pLakQvby9BWWJQZjNta1NnaG9a?=
 =?utf-8?B?U1UzaHZmUndkemVpdkFBTnNzaWNmWC81WEw1NGNZWXBVNzA3bDdWZ1NZbVBj?=
 =?utf-8?B?T3JlTXZBUWxRamlxb2M1Mm1vMTB6OHpBbklDR1BHUkw3cDRFMVZOODJFNjRN?=
 =?utf-8?B?SzNqbmpIZk9VUjVXSjZwYU0rR25yYU1PYS9MZzJJd2hDdlo5MlEyS2JWRkhm?=
 =?utf-8?B?YjFLeVpSTld2MGdKREU5M1ZJdStkMEZ4ZFI5SjZJOVZ4Wmh6elFkdzZaUVNW?=
 =?utf-8?B?eVZOcitVNTdTYkllbDcvcWpqc1ZBSHpOcHpsZmp3bWVCRlVEK3FRc3laNXJp?=
 =?utf-8?B?dlVzQzdZYWVxRW0vTlVLeGhjT3l5Mng2L0R6cmhEUFd0anJQUlRNV0xIanpt?=
 =?utf-8?B?cDIrNnV1TWdpZm5DNnEzaE81VytCYkV4RUMvYVhZT3VORTlhVWF0VWJMSDNq?=
 =?utf-8?B?bm84WnhnWm9nY2dUS2ZwLzI2MERjcHo1a1FKL2o0cngvUndvSENwMmRFRlpQ?=
 =?utf-8?B?NEVCVis3bmpIYmhLTDdOTHBocDJtRUNsQkVHTXJuVEthM3JCSkRGSExSSlhQ?=
 =?utf-8?B?WFZuaUxlNjRaWGY1aGpCTWxjczhKTWFlekhIMC9vZmVQQm9OTHdTVzg2VFV3?=
 =?utf-8?B?TzhmNEpYQW9aRU9xaWpPbkRyMlgwZHc0VjVSd0VaaTI4MTdVZmMydjNOeG5n?=
 =?utf-8?B?UTIwdHgvT0J2SG1FclBITHlNY0NaS1dqMG8yTmcycWJZWjhKUlllUUMrczV4?=
 =?utf-8?B?NEp5VThWMW4vdlNKcHp2cTR3bU5oRVBZYXhGVFIxUk8xSnBkMC9BYWd5M0pW?=
 =?utf-8?B?eGJzK2ZyTWpaSWhBVEVRRmtUZlRtWThQa3cyNEdnZExFWkQ3bjU4UHRlWGVD?=
 =?utf-8?B?a1E1ZVFBUlRnNW9LMzR5R1lJMnNldFlCNGlmMGxaSzJaYlgzM1J5Zz09?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5c33cc-abff-420a-01d9-08d9c0eadf68
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7033.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 23:22:05.5631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yym69CXYq2TlHgd9FTRW07169/XTU/flm+dz8MC495rGBPAcqOmEGMrWi8/J3NvdkIa/lcBa6GhcJWKOqdnrQ8F5HMRsuUh6dSeH3mHtbx64bI9Um06rrdAqymK3GN49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7155
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mark,

Thank you for the initial feedback!

On 11/24/2021 1:51 PM, Mark Rutland wrote:
> Hi,
>
> I haven't looked at this in great detail, but I spotted a few issues
> from an initial scan.
>
> On Wed, Nov 24, 2021 at 12:07:07PM -0500, Tyler Baicar wrote:
>> Add support for parsing the ARM Error Source Table and basic handling of
>> errors reported through both memory mapped and system register interfaces.
>>
>> Assume system register interfaces are only registered with private
>> peripheral interrupts (PPIs); otherwise there is no guarantee the
>> core handling the error is the core which took the error and has the
>> syndrome info in its system registers.
> Can we actually assume that? What does the specification mandate?
The ARM Architecture Reference Manual Supplement RAS document 
(https://developer.arm.com/documentation/ddi0587/latest) states in 
section 3.9 the following:

"For an Arm Generic Interrupt Controller (GIC), if the error records of 
the node that generates the interrupts are
only accessible via the System registers of one or more PEs, Arm 
strongly recommends that the interrupt is a
Private Peripheral Interrupt (PPI) targeting that PE or one of those PEs."
>> Add logging for all detected errors and trigger a kernel panic if there is
>> any uncorrected error present.
> Has this been tested on any hardware or software platform?
Yes, I have tested this on Ampere Altra hardware. I've tested both the 
PPI and SPI interrupt handling as well as system register and memory 
mapped interface options.
>
> [...]
>
>> +#define ERRDEVARCH_REV_SHIFT	0x16
> IIUC This should be 16, not 0x16 (i.e. 22).
Yes, this should be 16. I'll fix that in the next version.
>> +#define ERRDEVARCH_REV_MASK	0xf
>> +
>> +#define RAS_REV_v1_1		0x1
>> +
>> +struct ras_ext_regs {
>> +	u64 err_fr;
>> +	u64 err_ctlr;
>> +	u64 err_status;
>> +	u64 err_addr;
>> +	u64 err_misc0;
>> +	u64 err_misc1;
>> +	u64 err_misc2;
>> +	u64 err_misc3;
>> +};
> These last four might be better an an array.
Will do.
> [...]
>
>> +static bool ras_extn_v1p1(void)
>> +{
>> +	unsigned long fld, reg = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
>> +
>> +	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64PFR0_RAS_SHIFT);
>> +
>> +	return fld >= ID_AA64PFR0_RAS_V1P1;
>> +}
> I suspect it'd be better to pass this value around directly as
> `version`, rather than dropping this into a `misc23_present` temporary
> variable, as that would be a little clearer, and future-proof if/when
> more registers get added.
That's a good point. I'll update this in the next version.
> [...]
>
>> +void arch_arm_ras_report_error(u64 implemented, bool clear_misc)
>> +{
>> +	struct ras_ext_regs regs = {0};
>> +	unsigned int i, cpu_num;
>> +	bool misc23_present;
>> +	bool fatal = false;
>> +	u64 num_records;
>> +
>> +	if (!this_cpu_has_cap(ARM64_HAS_RAS_EXTN))
>> +		return;
>> +
>> +	cpu_num = get_cpu();
> Why get_cpu() here? Do you just need smp_processor_id()?
>
> The commit message explained that this would be PE-local (e.g. in a PPI
> handler), and we've already checked this_cpu_has_cap() which assumes
> we're not preemptible.
>
> So I don't see why we should use get_cpu() here -- any time it would
> have a difference implies something has already gone wrong.
Yes, will update.
>> +	num_records = read_sysreg_s(SYS_ERRIDR_EL1) & ERRIDR_NUM_MASK;
>> +
>> +	for (i = 0; i < num_records; i++) {
>> +		if (!(implemented & BIT(i)))
>> +			continue;
>> +
>> +		write_sysreg_s(i, SYS_ERRSELR_EL1);
>> +		isb();
>> +		regs.err_status = read_sysreg_s(SYS_ERXSTATUS_EL1);
>> +
>> +		if (!(regs.err_status & ERR_STATUS_V))
>> +			continue;
>> +
>> +		pr_err("error from processor 0x%x\n", cpu_num);
> Why in hex? We normally print 'cpu%d' or 'CPU%d', since this is a
> logical ID anyway.

I will update to use decimal print.

>> +
>> +		if (regs.err_status & ERR_STATUS_AV)
>> +			regs.err_addr = read_sysreg_s(SYS_ERXADDR_EL1);
>> +
>> +		misc23_present = ras_extn_v1p1();
> As above, I reckon it's better to have this as 'version' or
> 'ras_version', and have the checks below be:
>
> 	if (version >= ID_AA64PFR0_RAS_V1P1) {
> 		// poke SYS_ERXMISC2_EL1
> 		// poke SYS_ERXMISC3_EL1
> 	}
Will do.
>> +
>> +		if (regs.err_status & ERR_STATUS_MV) {
>> +			regs.err_misc0 = read_sysreg_s(SYS_ERXMISC0_EL1);
>> +			regs.err_misc1 = read_sysreg_s(SYS_ERXMISC1_EL1);
>> +
>> +			if (misc23_present) {
>> +				regs.err_misc2 = read_sysreg_s(SYS_ERXMISC2_EL1);
>> +				regs.err_misc3 = read_sysreg_s(SYS_ERXMISC3_EL1);
>> +			}
>> +		}
>> +
>> +		arch_arm_ras_print_error(&regs, i, misc23_present);
>> +
>> +		/*
>> +		 * In the future, we will treat UER conditions as potentially
>> +		 * recoverable.
>> +		 */
>> +		if (regs.err_status & ERR_STATUS_UE)
>> +			fatal = true;
>> +
>> +		regs.err_status = arch_arm_ras_get_status_clear_value(regs.err_status);
>> +		write_sysreg_s(regs.err_status, SYS_ERXSTATUS_EL1);
>> +
>> +		if (clear_misc) {
>> +			write_sysreg_s(0x0, SYS_ERXMISC0_EL1);
>> +			write_sysreg_s(0x0, SYS_ERXMISC1_EL1);
>> +
>> +			if (misc23_present) {
>> +				write_sysreg_s(0x0, SYS_ERXMISC2_EL1);
>> +				write_sysreg_s(0x0, SYS_ERXMISC3_EL1);
>> +			}
>> +		}
> Any reason not to clear when we read, above? e.g.
>
> #define READ_CLEAR_MISC(nr, clear)					\
> ({									\
> 	unsigned long __val = read_sysreg_s(SYS_ERXMISC##nr##_EL1);	\
> 	if (clear);							\
> 		write_sysreg_s(0, SYS_ERXMISC##nr##_EL1);		\
> 	__val;								\
> })
>
> if (regs.err_status & ERR_STATUS_MV) {
> 	regs.err_misc0 = READ_CLEAR_MISC(0, clear_misc);
> 	regs.err_misc1 = READ_CLEAR_MISC(1, clear_misc);
>
> 	if (version >= ID_AA64PFR0_RAS_V1P1) {
> 		regs.err_misc2 = READ_CLEAR_MISC(2, clear_misc);
> 		regs.err_misc3 = READ_CLEAR_MISC(3, clear_misc);
> 	}
>
> }
>
> ... why does the clearing need to be conditional?
I like this proposal and will adopt it in the next version. The clearing 
is conditional based on an option in the ACPI table. The misc registers 
report mostly IMPDEF information which may or may not need to be cleared 
after reporting depending on the hardware IP.
>> +
>> +		isb();
>> +	}
>> +
>> +	if (fatal)
>> +		panic("ARM RAS: uncorrectable error encountered");
>> +
>> +	put_cpu();
>> +}
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index e3ec1a44f94d..dc15e9896db4 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1573,6 +1573,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>   	{ SYS_DESC(SYS_ERXADDR_EL1), trap_raz_wi },
>>   	{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
>>   	{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
>> +	{ SYS_DESC(SYS_ERXMISC2_EL1), trap_raz_wi },
>> +	{ SYS_DESC(SYS_ERXMISC3_EL1), trap_raz_wi },
> This should be a preparatory patch; this is preumably a latent bug in
> KVM.
I'll separate this into it's own patch. It's not just a bug in KVM, 
these system registers are not defined at all today in the arm64 
sysreg.h file (adding those is part of this patch as well).
> [...]
>
>> +static struct aest_node_data __percpu **ppi_data;
>> +static int ppi_irqs[AEST_MAX_PPI];
>> +static u8 num_ppi;
>> +static u8 ppi_idx;
> As above, do we have any guarantee these are actually PPIs?

Yes, aest_register_gsi() sets these up so that only PPIs are added to 
the PPI list.

>> +static bool aest_mmio_ras_misc23_present(u64 base_addr)
>> +{
>> +	u32 val;
>> +
>> +	val = readl((void *) (base_addr + ERRDEVARCH_OFFSET));
>> +	val <<= ERRDEVARCH_REV_SHIFT;
>> +	val &= ERRDEVARCH_REV_MASK;
>> +
>> +	return val >= RAS_REV_v1_1;
>> +}
> Is the shift the wrong way around?
>
> Above we have:
>
> 	#define ERRDEVARCH_REV_SHIFT 0x16
> 	#define ERRDEVARCH_REV_MASK  0xf
>
> 	#define RAS_REV_v1_1         0x1
>
> .. so this is:
>
> 	val <<= 0x16;
> 	val &= 0xf;		// val[0x15:0] == 0, so this is 0
>
> 	return val >= 0x1;	// false
>
> It'd be nicer to use FIELD_GET() here.
>
> As above, I also think it would be better to retrun the value of the
> field, and check that explciitly, for future proofing.
Yes, I can do that. When I tested this the IP I used did not have a 
DEVARCH register which followed the spec, otherwise I would have caught 
this.
>
> [...]
>
>> +static void aest_proc(struct aest_node_data *data)
>> +{
>> +	struct ras_ext_regs *regs_p, regs = {0};
>> +	bool misc23_present;
>> +	bool fatal = false;
>> +	u64 errgsr = 0;
>> +	int i;
>> +
>> +	/*
>> +	 * Currently SR based handling is done through the architected
>> +	 * discovery exposed through SRs. That may change in the future
>> +	 * if there is supplemental information in the AEST that is
>> +	 * needed.
>> +	 */
>> +	if (data->interface.type == ACPI_AEST_NODE_SYSTEM_REGISTER) {
>> +		arch_arm_ras_report_error(data->interface.implemented,
>> +					  data->interface.flags & AEST_INTERFACE_CLEAR_MISC);
>> +		return;
>> +	}
>> +
>> +	regs_p = data->interface.regs;
>> +	errgsr = readq((void *) (((u64) regs_p) + ERRGSR_OFFSET));
>> +
>> +	for (i = data->interface.start; i < data->interface.end; i++) {
>> +		if (!(data->interface.implemented & BIT(i)))
>> +			continue;
>> +
>> +		if (!(data->interface.status_reporting & BIT(i)) && !(errgsr & BIT(i)))
>> +			continue;
>> +
>> +		regs.err_status = readq(&regs_p[i].err_status);
>> +		if (!(regs.err_status & ERR_STATUS_V))
>> +			continue;
>> +
>> +		if (regs.err_status & ERR_STATUS_AV)
>> +			regs.err_addr = readq(&regs_p[i].err_addr);
>> +
>> +		regs.err_fr = readq(&regs_p[i].err_fr);
>> +		regs.err_ctlr = readq(&regs_p[i].err_ctlr);
>> +
>> +		if (regs.err_status & ERR_STATUS_MV) {
>> +			misc23_present = aest_mmio_ras_misc23_present((u64) regs_p);
>> +			regs.err_misc0 = readq(&regs_p[i].err_misc0);
>> +			regs.err_misc1 = readq(&regs_p[i].err_misc1);
>> +
>> +			if (misc23_present) {
>> +				regs.err_misc2 = readq(&regs_p[i].err_misc2);
>> +				regs.err_misc3 = readq(&regs_p[i].err_misc3);
>> +			}
>> +		}
>> +
>> +		aest_print(data, regs, i, misc23_present);
>> +
>> +		if (regs.err_status & ERR_STATUS_UE)
>> +			fatal = true;
>> +
>> +		regs.err_status = arch_arm_ras_get_status_clear_value(regs.err_status);
>> +		writeq(regs.err_status, &regs_p[i].err_status);
>> +
>> +		if (data->interface.flags & AEST_INTERFACE_CLEAR_MISC) {
>> +			writeq(0x0, &regs_p[i].err_misc0);
>> +			writeq(0x0, &regs_p[i].err_misc1);
>> +
>> +			if (misc23_present) {
>> +				writeq(0x0, &regs_p[i].err_misc2);
>> +				writeq(0x0, &regs_p[i].err_misc3);
>> +			}
>> +		}
>> +	}
>> +
>> +	if (fatal)
>> +		panic("AEST: uncorrectable error encountered");
> Why don't we call panic() as soon as we realise an error is fatal?
Good point. We should panic at least before clearing the error. I think 
the panic should happen immediately after the aest_print() call, do you 
agree? We should still print the error before panicking (APEI/GHES 
prints the full error prior to panicking as well).

Thanks,

Tyler

