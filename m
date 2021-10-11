Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6EF4298AF
	for <lists+linux-edac@lfdr.de>; Mon, 11 Oct 2021 23:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbhJKVOU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Oct 2021 17:14:20 -0400
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:49376
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231994AbhJKVOT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 Oct 2021 17:14:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INbvzda6ldXEtdpsEMxCem/1CofFmuH/YVQYI6FJJfzWnRi6kYHrG87g0MJKxDh9YtTZZUpUrE/jmKlTZpmnY61rugKYWnVB1FVzGfQ8Z4mGCDGl3A3DqW3Wxw251FfLlWaIlM6NisCyCPLV0KdgHxyeZPwP8vprudIskdEqkUL7hUe11hja1P/Qhl0t7P4DE+w4G+jhVfZo26IGwZqPxTVwxlxsxAtM6fAgXVyy591UTrHtisViy4EQFTioAeFH3tmuX1U8g1/viw55w6vZYX1oi8ydSp3cEmwfTw1ex70rT+uylprtMERAY/i5mQqLJzqB4lj2g8ohVpt3MPrtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bbau4jObD8kPzXeqCOPZlLGirYGF3VUJsQn9SyqYelY=;
 b=QhFucq/b+W0TV1JKJpu+Zz7pPoqONS6y19INe+Gy5BzS1mjFxMaU6MPccOCorCCuMsKe3q3130ZmSUspUFhvUl2AS0plbMmemXSUJIcgEMBbqE1sRtXJbKjJMv7abjHmhmyYO0cGpJ7ME5zZb2ml5c+oWCbw61qHnxr1vgkFf2d66KePhR214UTMjQ4/lmP4T6HYZRj4OQuE9IJrgIfe4SORp0tS1xzBuH+Lhm9ObF1iqLO/ffTf6LZR3MtvZS4yK0g/XQiq7VULhMg0l7q++qE1o9HfqrsGnggRE0VLdAm9c64D79y0uiNKf31+ViSGT5UzFaJU4AE0wNXIsB3+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bbau4jObD8kPzXeqCOPZlLGirYGF3VUJsQn9SyqYelY=;
 b=4XOD0lEO3Zx62DlNddJCF+luzEPJZiIJwa+uxN5nkOTIqK495KNFSglcMoDLtsl+e2ZSQZv+fUIrGeQxB4UbSIlzpV9J6nIoGp5yR9ij/SGAFXZA8RZu3sPeRhRBbCR2BHQw+hlvYIEHZdSNKI5RqOVTIVCmrv+CdbAf8fTCrao=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BYAPR12MB2776.namprd12.prod.outlook.com (2603:10b6:a03:67::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 21:12:16 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86%7]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 21:12:15 +0000
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Subject: Re: [PATCH 1/5] x86/mce/inject: Check if a bank is unpopulated before
 error simulation
To:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210915232739.6367-2-Smita.KoralahalliChannabasappa@amd.com>
 <YU2Lm+11Pqg/RBK3@zn.tnic>
Message-ID: <78bec0e8-a64a-466c-4245-2386de7db5c9@amd.com>
Date:   Mon, 11 Oct 2021 16:12:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YU2Lm+11Pqg/RBK3@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::25) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
Received: from [IPv6:2601:647:5f00:2790:5c4:94b9:8114:59ac] (2601:647:5f00:2790:5c4:94b9:8114:59ac) by BYAPR05CA0084.namprd05.prod.outlook.com (2603:10b6:a03:e0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.5 via Frontend Transport; Mon, 11 Oct 2021 21:12:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 398aa8bb-6dbe-4498-9892-08d98cfbcd13
X-MS-TrafficTypeDiagnostic: BYAPR12MB2776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2776AF2893A9110D6218D7C390B59@BYAPR12MB2776.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rv8R0y4k2QWkTCOfHmDp6OWuIrHuKwR+5O3AAdVWgA8kAjM5y5nmMB7/xec7xS3viwIMJYO/8ljA4YogVaeal/cQ3AduvVATsvyzWI8vAOc7465sUNRsEediVPrZ3/+zbzz40otZOVqRhEewrHXTHy/xFhFToXMrDX7nVGXMYUuQ0v370LvrUvokcftzI9jyOY+eYESKKdR/p4TD8Gz5El1rrXtjnm8MYoH4r6XM50xr8rnkOpJ/pMI1PVC721LDDkiKAUkxC03bx2rfbBtTi4DtsqUj2tKDNXKg71oiu8r23XB4zW+27JGwI0nbzmJQy1Y4uXYamJARM1vI0pLg+z79gI3bLtzd3qqNBreccy5aEyeYN/yhGfo0C1yBlJWjtYlAJjSk55YyS6u+PV2XseVdQpno5TApRnss2fkSVe17a0y+fITlDm/r7ucT2JoYhvMjqzW5NehjqKilqEvi2ZMa+YunmDGjjYnUDP6qslcCqt0GYwDrp+HNVN5muwboleZKx4ryftDJWqGi5ZOzn/rA1kBJekuf0zIjqjRrQJTPuvF8ftfErfQ+PiOEmYunKcUeKA8sxq/qURfIBgrZnp7QP86jdhGZZP5qIwXly/j+AnjLsvOLdOXIKaF4LgNlnvU35gmq8kIuCrOTMiyVrbSZoR3ccMaPmoun8tW62h96XQmh1Y+aqnMqJs7nqlYhdf/pqwS4eohDYFtKmaHvNGtBIxCMqIIFR7vuvMExXW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(110136005)(15650500001)(6486002)(6636002)(2906002)(66556008)(31686004)(66476007)(8676002)(31696002)(66946007)(83380400001)(4326008)(186003)(36756003)(54906003)(508600001)(38100700002)(2616005)(8936002)(53546011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eC8rOHVrRUFlSmlzdHVqNWRHbTd0WkdSUEpNVlV6cmhJZnpNblhvSDlhQ0Q4?=
 =?utf-8?B?N3VHS3Q3ZEdzaWtiUENiVWxERC9ZSFFXUlFhd1BYUGZ2V01QMHhTL3RvUTFD?=
 =?utf-8?B?R2Z0aWVienVEUUs3OWdWMkJNSk02OVE3MjlMeDU4RlYxNTVpK1BraEwvcnp0?=
 =?utf-8?B?dHMxem5ldTJTRzZNZXdqZlZZTFFEWnc4aUFvVU5nd0FDUHdYajVpYitLb2h5?=
 =?utf-8?B?RUNWdzJoRTFwWkZCeWxXRlBSdkxtL2tzTmNEaHRSMUl5aGxWR2gzRnkwSFJB?=
 =?utf-8?B?MFIvbjdaczB2V3lpL0FjcFRoSlN6ZDR2YXJGWlppVklBUWw4eUx5YW1wMkYx?=
 =?utf-8?B?Y1lDd2dLdERQcGpsOTlHN0M0Vk4yUmtIa2pHYzFuWjVTOEdiYTE0ZDdNUE9j?=
 =?utf-8?B?MnZsS1JrV2hZdFJCS3JRTThJcElMZjJxclRiazJ1MGcySjg4RlV1c1orUXA1?=
 =?utf-8?B?dm43cnBQV2x4L3RmdkxQbkhFWlFIQkpRSmFWS0JUOFYxRFVySnJ2bitXbnZr?=
 =?utf-8?B?N2VNZVJFUHFvWTl0K0kyZlZJdys3NWpLNFZZZzZEamtiU2d1TFp1dFBLbDRH?=
 =?utf-8?B?NjhWSUJVVi9KVDkvbnZiVFgvQXdSSXEvazJNam9SZlZIanNOZW1jMzl1YjVD?=
 =?utf-8?B?T3Ayc09XYVYvUHJjcHhnM25EK092ZHpoUmhqaU1lNU5Fd2RjZk5ZdFJ2Snkx?=
 =?utf-8?B?OWlDNklJdDkzanA1N0VyMDB3S2t3KytMa3ZnTEtCYlhPMEh4b1pPOGdPQ3Y3?=
 =?utf-8?B?S1FWMytZMEV1T1VEUjhhU3dQTjZUUHEyRTc2LzhHQjRORWNERm5PZkpBQ0Q5?=
 =?utf-8?B?bnVoTU5Nczl6bjdnTTdLN1B6bnNKbEJPUXRCUjN3Q3A3TGtWejArVU43WWhV?=
 =?utf-8?B?MVVaaWdoVlc2VlU3cTkzOE9qM2Q1NXN1STBuV0VXQk1SN3ErYnpCWXErR29u?=
 =?utf-8?B?VDc2K0FhWnd5d3lKZEs5Ky9yTXEyVkpmcmtRQTBzQ21Ba3lmdlJadEp4cEFF?=
 =?utf-8?B?M08rSXUyczVKVEc4TUpHOVpwVmZKT2h4T1VHR2VIdUtmM3JxWFBYc2doL3k1?=
 =?utf-8?B?bjVtengyR1JCQmllWVpxTlptQ2V6cnh6cldSZHlYWEtuYnVvbnJ2YS95eE5D?=
 =?utf-8?B?Vm5qdndnNGhDOHJnOFB0eWJzbkFzMXNiaDN5ZjNhR1hHTDZxSHRzd3NpbFBo?=
 =?utf-8?B?RUhtSkU3OFBQcDFkL1Y5NVU4a0N3cDdzS2VTNTZqTVRsWGZqWUdyVkNOam8r?=
 =?utf-8?B?ZWt0Y2JBa2Uxb242Q2Z0TWxyOGdET2RPQVlxR2g5a08wNUpjTW02TDlFTVNQ?=
 =?utf-8?B?RHArY0RRc1lmbTlMR09Wb0xodThOZG5KVndSYjErQk5QWXZoZFZHZStvankr?=
 =?utf-8?B?K0hVV3paait6TTVuS0FXNFY4cTV3NFF5elJmZkZXNVZhWXpFdzU3ZDdLdmlV?=
 =?utf-8?B?SXFkNXpzTnZaR2t6cE9QMDl3TW5EVzlqWUt1OW1FSlE2SXQ5cTAwOVp0TmxV?=
 =?utf-8?B?aC9mZ0lRdkxiOGFhL0ZUa2pIZ3pRMm9VMzlFUWViVlVtY3JKTlEwK05lbERm?=
 =?utf-8?B?OVBzUXN6RjA0VGJJck9ZMGNnZndyOUFQUWZqUE9VUHFMYzRtVnRjanhScHZB?=
 =?utf-8?B?RTRoUVY3d0QySU5MTUJEOC81UlJ5MTRzc2liUE94OVZnMTBQR0praEdqUE9T?=
 =?utf-8?B?ZmNNNjBUMTZiWGpJUDdRR3lsb3A3cldobXh1N0daY3N6ckdYUEFxUEpRL0FH?=
 =?utf-8?B?T0RnMW84d1hoajhjU3RsOWVYcjQvTEE0NXljS21zQlZNRld0Q2FKQTQ5NFZu?=
 =?utf-8?B?T0UvbzdVQk12K1cvOHVtZW5ZcGllVWcvVTkvTURqenNwRXRyc0I5ZHBtV3Zi?=
 =?utf-8?Q?xIUZci4LMnXrE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398aa8bb-6dbe-4498-9892-08d98cfbcd13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 21:12:15.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2jRA7mcQ56NJIYzF3R8rpx8RtmM86In/75kG5HDlXNOgnloV+xxDWf6o5xaZzdTwm4ygeVa0f1Dw0le3mokSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2776
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

Sorry for the delayed response.

When I was coding this up, I came across few issues. Mentioning below.

On 9/24/21 3:26 AM, Borislav Petkov wrote:

> On Wed, Sep 15, 2021 at 06:27:35PM -0500, Smita Koralahalli wrote:
>> The MCA_IPID register uniquely identifies a bank's type on Scalable MCA
>> (SMCA) systems. When an MCA bank is not populated, the MCA_IPID register
>> will read as zero and writes to it will be ignored. Check the value of
>> this register before trying to simulate the error.
>>
>> Signed-off-by: Smita Koralahalli<Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   arch/x86/kernel/cpu/mce/inject.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
>> index 0bfc14041bbb..51ac575c4605 100644
>> --- a/arch/x86/kernel/cpu/mce/inject.c
>> +++ b/arch/x86/kernel/cpu/mce/inject.c
>> @@ -577,6 +577,24 @@ static int inj_bank_set(void *data, u64 val)
>>   	}
>>   
>>   	m->bank = val;
>> +
>> +	/* Read IPID value to determine if a bank is unpopulated on the target
>> +	 * CPU.
>> +	 */
> Kernel comments style format is:
>
> 	/*
> 	 * A sentence ending with a full-stop.
> 	 * Another sentence. ...
> 	 * More sentences. ...
> 	 */
>
>> +	if (boot_cpu_has(X86_FEATURE_SMCA)) {
> This whole thing belongs into inj_ipid_set() where you should verify
> whether the bank is set when you try to set the IPID for that bank.

I do not have the bank number in order to look up the IPID for that bank.
I couldn't know the bank number because mce-inject files are synchronized
in a way that once the bank number is written the injection starts.
Can you please suggest what needs to be done here?
  
Also, the IPID register is read only from the OS, hence the user provided
IPID values could be useful for "sw" error injection types. For "hw" error
injection types we need to read from the registers to determine the IPID
value.

Should there be two cases where on a "sw" injection use the user provided
IPID value whereas on "hw" injection read from registers?

I'm pasting the code snippet after rework on the comments.

static int inj_ipid_set(void *data, u64 val)
{
         struct mce *m = (struct mce *)data;

         if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
                 if (val && inj_type == SW_INJ)
                         m->ipid = val;
                 else {
                         rdmsrl_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(?),
                                       &m->ipid); // Requires bank number here.
                         if (!m->ipid) {
                                 pr_err("Cannot set IPID - unpopulated bank\n");
                                 return -ENODEV;
                         }
                 }
         }

         return 0;
  }

Please let me know what do you think?
Thanks,

>> +
>> +		/* Check for user provided IPID value. */
>> +		if (!m->ipid) {
>> +			rdmsrl_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val),
>> +				      &m->ipid);
> Oh well, one IPI per ipid write. We're doing injection so we can't be on
> a production machine so who cares about IPIs there.
>
>> +			if (!m->ipid) {
>> +				pr_err("Error simulation not possible: Bank %llu unpopulated\n",
> "Cannot set IPID for bank... - bank %d unpopulated\n"
>
> Also, in all your text, use "injection" instead of "simulation" so that
> there's no confusion.
>
> Thx.
>
