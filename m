Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED70C419F81
	for <lists+linux-edac@lfdr.de>; Mon, 27 Sep 2021 21:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhI0Txj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Sep 2021 15:53:39 -0400
Received: from mail-dm3nam07on2071.outbound.protection.outlook.com ([40.107.95.71]:10969
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236243AbhI0Txi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Sep 2021 15:53:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us4++jc4Ifwsim/Q4D5/xq+x3o7Fanj5uP6gk4Cq4Jm8+EgQsL0NpYvd2cWt+waTbTQJ2T433nq5xrqX61EgfBbcJRsDe3JMYtw0r1X0HS2Ov8S0SRT2pbd8LSorO8cjCvQAz/2W3mLYDRf81KnSlGX3QZBmQiiAqYToDUHm8rDI9y+Y7HrmX/5KBvQ3p4ubGbRRgNnDvyFOiCmZV3WnOyNzifZLLHncsXqCpr2LVJOWu3RFB7mlIPfpJLpWUTCDBGzPqO3GXERbZ29RbAaptGXmG8GXmC0SMT+dyBI5ghQ/Dtchu5IAHuyBYvDGUG+iWGaLEhmDI/fDTD3lGUlU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=A7N/TxRmFVY9xHud2DJXleMjbA2CLRIr6VQZBa+ZYEQ=;
 b=QJUD39L3lgyN0Mp9XxQoeoKjgc0rHWC9A6gXmsUgz2tVJanxmTdt7/ENPYLkU0q0HTcBxgtMg1roohsFNqUuuq3tGDyHiQVV0vNTZVNyELtDW2bgCcCbDzxuMOkkwI2MREeAoPpC/YGKULLu6mXLScHVx5w66CvfFUeZ7eiqvDNkjCQ7o7rsLcU/Y3aL69aeh4kgF7ZngSNTMUQybCchkfJjawQK6h9A1Cov6HsG0W1rxyVwHy1EZKCN1W/7b7hAN6U8I8bW77ibG65LNVW9C7xGD8lT2E34NRp2QIFcaC2kKnfwH2/xHoP7K76+r0H0mLEGbH4/UAISBGNrp4D38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7N/TxRmFVY9xHud2DJXleMjbA2CLRIr6VQZBa+ZYEQ=;
 b=wqm7ihL/a33+EdyVEKxZdn6B/x2pLW/Jc57rOBCpNhMYKfWBAz8nD77ANs3KoVYUkm25CI5Dccj4zCyHfHLVuoElpojSjqcyqnWkbgvXmwZSUrxycwHTbaNaAgVij+pmSkCQnSC44lo5P4Akvrzz/MAGeTt21w7cgcBX5+XQ+Q4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BYAPR12MB3317.namprd12.prod.outlook.com (2603:10b6:a03:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 19:51:58 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::fd4d:81ae:aa97:718b]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::fd4d:81ae:aa97:718b%6]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 19:51:58 +0000
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
From:   Smita Koralahalli Channabasappa <skoralah@amd.com>
Message-ID: <60d4f6be-76f7-e4b6-6fb5-2af78b01d32d@amd.com>
Date:   Mon, 27 Sep 2021 14:51:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YU2Lm+11Pqg/RBK3@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
Received: from [IPv6:2601:647:5f00:2790:8356:8578:64cd:ec49] (2601:647:5f00:2790:8356:8578:64cd:ec49) by BY3PR10CA0005.namprd10.prod.outlook.com (2603:10b6:a03:255::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Mon, 27 Sep 2021 19:51:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a827c3ca-1022-4cb5-6fec-08d981f043d8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3317F52C3C961D72FCF6104B90A79@BYAPR12MB3317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tCGpSl+wuFIQCENVVnGZdSYZsqnFtvFBHQgdnOdjYoIjTZoGdEJz4ba+rFLefrwC975Lbawg9VswxxdS8Gh3YQiHFBXs6M8tTu9pL1sK6uNvgzyyrD+GinWQfHyTpKOkRl1rBI7T2oY61NxsIL+sEDim/rOUNCmLOeS9OmG+QKLM5kfFOYYF9FS/22euo9esaZdA9Ae4uSady4Q2o+td4SZRqUY1vQNPlqVU+hinx0s3HSZMFNjjhmx5g+4npFWTSnfC/gmGiW7Th/95DgwmzFd2s5E2cW7jSxUcd/JM4kCmmhmxQ86auXiYQxWafFk5BtxrPOul7Astzn9gDL6XkMQ3zOD5JbKKf5emONAVfgWv5dVcM5WH1ozIl3+0hvaq+m0S2sTdMcIAu5TFUUjz5Im9HDWy4m3hQALFqWhUBpq/S3glOnddO0xiS8p6gSNDvlSNjAeCQOLhGyaDj7eQHNkXPWWgtk+MvzlsKqHBKLQxIUgy6oag8Yk5iQEgIEBxe5wHn9VNEjsnhH06YwoBzr7SQbMPiG3Myu643n54HQVxiLbG99H3cYiRteba0FRMAbs+rzSFIhHiunEioo9pgLqBKWzo29/S5DFmnVvjaJqdtw2EzPhcjwwiADT+IJUpyJmVZ2+dXqGQmQb48ywlm6yThJQG5HBkckhw7liEGrLLaS9KZRds6BpJnAgk1gw3cpzWuYXXFJ9xt9xAJjzD7R7mC7MQEo6CGJZjfDrKkfviNP9qj3swRCj6ml53prf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(2906002)(8936002)(110136005)(8676002)(15650500001)(6486002)(508600001)(316002)(38100700002)(31686004)(186003)(66556008)(36756003)(31696002)(66946007)(6636002)(52116002)(2616005)(4326008)(5660300002)(83380400001)(66476007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXhaYldvN09ZZG5MUTVvM09RWk04elRQS3hXTmtPdWE5WFBrd1puQUVPVGJ5?=
 =?utf-8?B?R1ZheTVuVUpJTFhEK3dINWFnRFo2U3ZLL2pMV0h2UllLSUpMWlcwL3hyVTlP?=
 =?utf-8?B?bVFrTS9XZ09NSFZ5cnlUYmk4Z0I2RVU5YkNSK1VjY0lXSjhabmtTYStSY01z?=
 =?utf-8?B?UkN2Y3ZrVGYwR1diT0ttMGxzQXZyNzJ4S2lQS0hpOGtEelZTUzVhK3hjdEtl?=
 =?utf-8?B?S3l0NmdEaGxUVHZwakd3dlE0b3JVYURuQmlqK0RXd2VYRmxCOUJ6WTdONlVT?=
 =?utf-8?B?OVZuNGRQYWVNc0VuUGdxbktQVmtvR1laN3BXK2hTb080eW1HbEs1Mi8za0kr?=
 =?utf-8?B?eG9xWDM2THFlRXFxSkpKOXp0dG5KbC9YTWRaSlk1YlliOU5TM0Z4ME5EUERx?=
 =?utf-8?B?ODZ2NVpTb2U5SjVoTG0vVFZLK0tkY2JBbm5BeHRiTlhBbHJtczFQdnRqVlVW?=
 =?utf-8?B?K2svc0hxNEw1d1NTNy9wemdjZzlhcGM5cG9ETEZXVmwxYkh5aVRraG9xY3ZY?=
 =?utf-8?B?eTJ3Ry9GVW1QeXBzbDkwdWlOS3hydi9Db1IraERNOEp3ZllzV2JaSUN2Wit4?=
 =?utf-8?B?Slg1QXhSVTZWd2VEZ0I3WkRZaWcwRU52YUN1TytHZ3ZrNGpMQ0w0UkNKY1hi?=
 =?utf-8?B?V1JVckptZXJKS002MUphUWk3VmpMWUUxWVlmelMxYVZzamdCbWhLSlNrM1Er?=
 =?utf-8?B?Q1c5cWY2Mk5wZzF6ODhTZTJDSFFMajMzUUR6NUZVbXZkZ205WVZlSG5hUitP?=
 =?utf-8?B?ejY3WUpnY3JzZHpOekJXblpvTFRYL1NGU1k3VzJUd1VyazAwN1VPZW9hVGJw?=
 =?utf-8?B?WFQxN1ZpaEZEZnpBZFozaElJNGNGdWVCb01IQUhYeWI0L1FGSnBFdmJUMEVV?=
 =?utf-8?B?V2xlanN1ZjRnb3gwaUJrTXVmQml6WWdyb25yL2dJcGFDWFh0LzdyT3d4MkRT?=
 =?utf-8?B?TmVOdHUxU2hhUlNYa01BT3VzS3p1dVEzNHp6QmpxMkRhaE1UODRlN3Z3UDM3?=
 =?utf-8?B?WFFCWFk3WDB5dkxyM2g1Tm4yVW5sMnpGM2FHVHViLzNNQXorRER1MzA2UG1y?=
 =?utf-8?B?VExQbVVGRUhEby9IM2xoRkVYSFJ2NlRaYyttWlhVNVdWT1pYeE5vUFF4ejl3?=
 =?utf-8?B?V0tIZU1XYnpNMUdLSmpsR2RXRk5SMFJ3MGZGL2RMank1TW9weDVWcFpVVTFz?=
 =?utf-8?B?TFJwZkJ0NHlsancrcGZjYldlT05mNmtWejVBRU9RKzQ5dWdJNFNkLzZyRkR2?=
 =?utf-8?B?OUo5TlNNeVpVMWVKNjZEajVDMncxMktwZkFxdTdhNHdCUnhlbVgwekgraVZO?=
 =?utf-8?B?SEV5OUFSRUNsdEJuNURKbktQQlEvYkhtYVdlRlhHRFMxV003akd5QVJWOUlU?=
 =?utf-8?B?Ry83c2VJOWZnbTlnWW1lZXJ6UjBWTU1uUFdKbHF5R1Nwc2p5TTRZSlc5aUsv?=
 =?utf-8?B?VGpWdHhzY29Cb2dNQVlzZ1IzM1h4alV6cEpjVEJkbXpQaE96QkNhRWI2ckNk?=
 =?utf-8?B?VWVpRTQ0eUU4M1poUlNoVFJrSzRzOTVEZ0t5T29Xb1NscmVyNGRHTGg5QmZK?=
 =?utf-8?B?L2ZNUFpSL0pXR2VmYVBrdTFWWjk5UXhLVDJVMG42NGFUQ2JXaW52endsSlRB?=
 =?utf-8?B?R05uNTVrcmxSSnJrZ0dUVGhzTkhGSWkzOGgyZHJWY0lleWIzYS9jMmFPWTZj?=
 =?utf-8?B?NkV0d2xqZWRzQk9vNjdFM2FmSEpTcXE5QU5VSDlybm9wblJKaFRvZVJudGFW?=
 =?utf-8?B?cVJwVG00SW9KbEQ0ak1nNStnREQ4TWJPbVl5OWxhMzQ3c1FGUnVmdlliNDIx?=
 =?utf-8?B?S3ZCZCtsaWdiZER5dTJSb0xiZmxiSmlDSWNkRTR2OVVSL1Z3TTdNZk9wcVZs?=
 =?utf-8?Q?bsrlfyrC9LCJF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a827c3ca-1022-4cb5-6fec-08d981f043d8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 19:51:58.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7iXb6BNndzWvLO/CgKY6MZrKrNPfgA4tgEtoEsG2bj8KpD5W/gZHA/K1aP3UXyIvN6zz1FBnOkbNIy9/cQujQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3317
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 9/24/21 3:26 AM, Borislav Petkov wrote:

> On Wed, Sep 15, 2021 at 06:27:35PM -0500, Smita Koralahalli wrote:
>> The MCA_IPID register uniquely identifies a bank's type on Scalable MCA
>> (SMCA) systems. When an MCA bank is not populated, the MCA_IPID register
>> will read as zero and writes to it will be ignored. Check the value of
>> this register before trying to simulate the error.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
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
>> +	if (boot_cpu_has(X86_FEATURE_SMCA)) {
> This whole thing belongs into inj_ipid_set() where you should verify
> whether the bank is set when you try to set the IPID for that bank.

Can you please elaborate on this? I'm not sure if I understood this
right. Should I read the ipid file to verify that the user has input
proper ipid? If ipid file reads zero then do rdmsrl_on_cpu?

Thanks,
Smita

>
> +			if (!m->ipid) {
> +				pr_err("Error simulation not possible: Bank %llu unpopulated\n",
>> +
>> +		/* Check for user provided IPID value. */
>> +		if (!m->ipid) {
>> +			rdmsrl_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val),
>> +				      &m->ipid);
> Oh well, one IPI per ipid write. We're doing injection so we can't be on
> a production machine so who cares about IPIs there.
>
