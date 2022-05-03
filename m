Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C52517C3E
	for <lists+linux-edac@lfdr.de>; Tue,  3 May 2022 05:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiECDca (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 May 2022 23:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiECDcY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 May 2022 23:32:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD73BBCD;
        Mon,  2 May 2022 20:28:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyieIfMIdiDWLUHlhXPg4yidGEx2jBzKzU8fdB/z3DxZYYc1puoM009VOPQK82Qw8TrvBYycREvLosUYLt5XomGfowfzJH9Y8zD0GLjVknBOtv6+whU0m3V7BNX0EHTTQQnLtWIJojGFzBLeOrHjYRG3qtH3ZWtaU9mG62Mu78QOaE5GFeYpawRlmYl40U9R8kS37Uwi3CAw20biT2E7H6qj3yBKiiyTXJ7krGakH3iBvIRLQK0MwSc+imol4AxulEYMrD9DViFWx67Y84F+9NpMbBGXGVnjR+sPmQgz1hwNuf0lIUFTJ0e+1X/wd8R469yL6UeebNhdHrVq96V2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+otrf9t5jsDFgaseDoJ2B8kx/MFDehEocrEgIGgRR2Q=;
 b=k8B2UTghWiC4mDhKCSe3qhvNB6QMFcolp79xc7uLwxL0zRMEEEzMAKfUJH9LJMfgOHqazsZyKLoJ+mI0q3xvlgfJY7nDl/OjJebofofZsT2nYw8fnvUqThaoFFURAvS4SZfBgQ6HfB/XZOs6SATG2llPkj062mEcAL00LeCJ8jaOXxdSrEx1gpvf1PUOLn0PmwSTm3leipzlyxqiVfCiKZKv0osH4zhy6r/9YH7HhPfgazb9DFYjtFFeRfoK8napVP4hbsF/uby5Smqjq86nnQ4rG6Ovwp6aQofbs3DhW2N2DdZuCvSAwXeOVEWwfwF3uv4VzCXAxGZV7t/YXvdSOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+otrf9t5jsDFgaseDoJ2B8kx/MFDehEocrEgIGgRR2Q=;
 b=ys4jMQFOWIq2Pbx0FByteJdwQ5f8ug1Yu4nmx09ZxgPTc40cPttNeleYQt3PfimHkK2vA1ndykAJYC99kfeZuLEWtoSabVn8P7viwTvBRyOveotppi5Vb7WN85FY2oUsLsHHimWozgy0gvKCB67VkQ5Gbss2Qw1c3LLhDBCvDCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BN6PR12MB1266.namprd12.prod.outlook.com (2603:10b6:404:14::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 03:28:49 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::c4e5:68d5:f7a5:7680]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::c4e5:68d5:f7a5:7680%7]) with mapi id 15.20.5186.028; Tue, 3 May 2022
 03:28:49 +0000
Message-ID: <3fd01af5-c665-6dbb-4ed4-dfc39109d63a@amd.com>
Date:   Mon, 2 May 2022 20:28:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/2] x86/mce: Check for writes ignored in MCA_STATUS
 register
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yk267A1MKOo2AlXQ@zn.tnic> <6cda2827-af75-589d-3e43-a287d6683e7a@amd.com>
 <Yl/PupT3bAfc4IBW@zn.tnic> <5512261e-085b-65fa-605b-38692769f89c@amd.com>
 <YmXQBbCz2T/Opv5+@zn.tnic>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <YmXQBbCz2T/Opv5+@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0705d17e-bed3-4bd1-9929-08da2cb509e3
X-MS-TrafficTypeDiagnostic: BN6PR12MB1266:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1266BBC64D5F5874799CB8CA90C09@BN6PR12MB1266.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: geovAxYpyXOAhVKuiRC+6d3eS/HmHUPKjrxVdbUAPAkH2hVt9AKsihQwW47l3WmgjmhFVV5Ire8zjZWTcMTZEcos68iVwnXY6E1VsAE61ZnFWWnCL2uzUH2pFIOUp3vzgjl6+w0rmsAocrLHY7VgbffUizu1q5X4tfDhP4U/duoMKkak09Rz8OVPd5ytm9dWls90OgtP05AOLKJbTM0s/pm3uMjrMyFQld9N4e3ekstlpeUzXuNT1OBHHrnC0+buiP1iWwIIEiNMH8rCs35svX8gzGUr8E0+RGOiy8hCVjRSFjfGLqmyllsXa3rO7SdKR6NoHKOMaI2BvvnjU3PMonLTHT8A9Jd+LdNGlcooVdUVbGHUDAdnwAwU8CvETL557FhUJ2UtusFeNiwrMw3XMPrPBDWO95TIAf9aO2QOjMhVHU4Zl//Y59rAsxGWbw2jI9tNOTBZNHCA9rQj3voFqKC9U63ibwpXSEsyaCMhtgIkMfHPtkCP2m9rd/55oT/wItUlbpzsXWVN95wAjx40k5FyXdX9nIiAAZjOQJVPSq3fB87BGGouQR+OGm8QBZKqlo4blraukG9GsqbYIeYnA0Of94fkoCONWNiF5kwG+xYZFgs1wD+PISbqxwVe7KNtb/VKpUWI3AE1ZkLCcWssN+oacGntc5cWTBPXvb1l0naY9xgE4IcmFYqqJch/Zhx38EHxixdoVCUFy4OMbsEwQTQ2JRvvpQhv2MMXgHoCZLReyf7TQANkIvlFuBgy+OIc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6506007)(53546011)(83380400001)(2616005)(31696002)(38100700002)(6512007)(316002)(86362001)(186003)(5660300002)(36756003)(8936002)(4326008)(8676002)(6916009)(54906003)(66556008)(66946007)(66476007)(508600001)(2906002)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTdhQjZza2NOc3l3a1pYN2M0S25ibjUyZFNsQTQxK3ByNExpUExRYUpSSXhh?=
 =?utf-8?B?RXRtTFNMTDF0eFMyZExBZG1EWUErK0QrRkc2Q1pnNExLRGZjRVFLVFV4ajFR?=
 =?utf-8?B?LzMrcGpNOW8vWjVLSkFDcm9UU0NqMDJwalY0RWhqTmxOK2FCalF4WnFUbzFw?=
 =?utf-8?B?M3NRWEJjaitJalcvYkJwMlJ4WjdYc2dralFtSHVFdmVzeXU1MnJwSGVJYldB?=
 =?utf-8?B?SU5PMXhzRmpFSzNaUGhmTFJxQW9ValFKSWJOQ3pjSWFQd0sveTRpVXRTb3Ft?=
 =?utf-8?B?M09uS1M1UjVUNFgyeThJU2ppOXhuODNDTjFoYkV2alJlL29scW9TM3RxakpK?=
 =?utf-8?B?M0h3TnA2cnVMaDBoRU1va3ZGQXE0K0xlcXV2SjN0SEF3c3FnV3lEdjRtVXc4?=
 =?utf-8?B?bmdhUWdMNGdqcUIzNEtlenlEUU5YUC9rb0tQWEZaTUN0NXp2WW1mbG9QRHhQ?=
 =?utf-8?B?TzZkNzFONlRKQnFBckJiN3l3UC82cEFMK1ZnRG01eGtKbnhPR0pKeHdsTFBS?=
 =?utf-8?B?VHFsbGdaQUZkckt6UFdaTDkxTFJTczh2eEdzbmlQc0hLK0NNbkJsUlM1Z1Vy?=
 =?utf-8?B?a3JJSTJZOS9vODcxelovc1dZSURMSExtV1IreWdiWTJLUWJOSUwrbXJibnh2?=
 =?utf-8?B?UVllU1g3Tm0zWC8xUEFIRm5NYTRFdFpIVmJZY3JrMlYvVE8wYnYwU2RxamZw?=
 =?utf-8?B?d0dNTDJVTXhtd3FJdHAxVW94MldaQ210NitXSkRqZ3dDMHBMdWNabkR3eXZN?=
 =?utf-8?B?eVlUUU53Y2xkbVNrVHdiMUwwSXZNVGlCTFE2TUFjbFRMNWUrY0V0WkRIK09z?=
 =?utf-8?B?SVJsRzBqWHkzQVNXZHJYSEZGNUk2ejhTRElJNGZxdkdyanhjN3U1ZlNCNVhX?=
 =?utf-8?B?WllSTlRUQ3llMkFRdko0Sk5ncFlHcklpQ2dueFY5NVMyQ3l6bm9SUU8zTXRD?=
 =?utf-8?B?bXhpVDZKN3NjYzU4NWhlVlMzODRYYThTQy93VkRWVXpUT3MyYVVsY2hjK2FP?=
 =?utf-8?B?TGZHbUVvT1I2LzJBTnNEZitXVWZSY09LdjNvWDQ3N1h4T0pQdFFqSDA5anpl?=
 =?utf-8?B?eHA1RHpBcWJsSVRSZTg2TUcvWEdabUIxdkZVaEZwcFZGVVdtSGFsRkRVWGpo?=
 =?utf-8?B?TGVCNVExY2RpMWh0b1dMYTgxOG9mbkFXYStGU2doMGN5UEcxMFdYUUxOWGJ3?=
 =?utf-8?B?UzBPV1pRL1RFT1JNaGJ5aHhmUlcxTzAvU0FHQ3VHS2VRdnNlZFVrWDlPZGgv?=
 =?utf-8?B?eERhWnVjRExhSm90YnIra1NnbjFrUWFKMFZRRG05ck14TFdkTSt1YUVWdGdy?=
 =?utf-8?B?MUgyQnhKS3cvTWtiamw1N3dYUmxKdldYN1VuUlB0Z3lFREp2VjhVeWp5UVlZ?=
 =?utf-8?B?UkZDdUxTYzFTVTgrM0JZWjlPVHpZZzRUZ05icU5iczRGVkNaUGo1T21VeHB4?=
 =?utf-8?B?V3dmcU04T3p1MDZIKy9FUlh2OTVwUmdBenhZdlRQRGlZak5JR3BEc2FjZ1ps?=
 =?utf-8?B?ZWZXQ2xxeGZUMFdla1NmVVZvaDA5L0d2RU9aYXlvTGZqaWp2Z2E3ekFPUk1G?=
 =?utf-8?B?ZU0vWUljcS9EWFB0TFJmTEJmVHdrUlVkVjZrYVpmUjJrTFlDR0tBMHZUd1Qx?=
 =?utf-8?B?MkR6RVdCK1JJRHpTeHZlQStQYWNxaldpSm1ZRlN1MWx0VUVJSHhFdnkxdGhw?=
 =?utf-8?B?VzRXWFFOVVRzRCsyWkt1U1hBQ29TR0QwNkFUdnhlUzN4WU8rOHJUaGJhT3hQ?=
 =?utf-8?B?VUo2UFUrcGVadVNZUUl6ejVhOS9WZnhweHZScG5yZGpGMG5ldGk2cHhsQlBC?=
 =?utf-8?B?V3MzMjQ5NGNsMkZaWTVoMzcrWmJ0Y1VkVm1wSzdQeFU0WGlXbFRnOGFoRUk0?=
 =?utf-8?B?cTRuOUhCUk43RWR2VldZNzV4T3YwOHFNemRnWDlHMXZQWHkydjN1emxZYllk?=
 =?utf-8?B?NEYrU1Njanc0N1pmSEJFUzJaQW5kbjNlOVhRdUN5aThIT0MyR01aYkM0eWdw?=
 =?utf-8?B?d3V1Rnl1d05yTjVwcXBRK0lHc1dNaTNKSmVyUFhFMlVvbEtHZHQzeHNvWHNW?=
 =?utf-8?B?RUFKbDE1S0hQcXI0eU0wM1ZmdHllNzh5S1pGb0xGc05ZZGgxVEFFa0lKRjEy?=
 =?utf-8?B?RXFRVWhmSUVIVDhxSEdGMmFwZGN4U3FFVk5Cd2RQaktwQTRSUVgwUThDZDky?=
 =?utf-8?B?Z29KQWhVeWNIVnhhL2xEcXVKZTZZcXpBNE9GeVpzVklCRzI2eHYxRlYvQm9C?=
 =?utf-8?B?TWtBRzd0UDNubHpJS0VNUEtwR3NLZ3Zndm9Rc0pyeFlGRmpCRVB1dERSN0c2?=
 =?utf-8?B?VjVSTkJINUlDdzNmSGIzT25TeFRLS0x4OWRlK0V6OGN3TlN5Vk93Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0705d17e-bed3-4bd1-9929-08da2cb509e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 03:28:49.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuyQFj4n9PIr67F+VgH10LGDf9LvqrdGwV6lTvYgxJnEkqcT0MY6S4+JdVY18d9EItFiSV+5C0yZV8iCalR5fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1266
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/24/2022 3:32 PM, Borislav Petkov wrote:
> On Thu, Apr 21, 2022 at 12:10:07PM -0700, Smita Koralahalli wrote:
>> Also, should we move this slightly before? In inj_bank_set() after we check
>> for sw injection and before reading IPID value?
> If anything, the proper place for this would be to do the check in
> flags_write() where you set the injection type and bail out if one of
> the !sw types is chosen.
>
> However, you must do the prepare_mca_status() dance first in order to do
> the check.
>
> Which means, you'd have to poke at the STATUS MSR of some bank and
> carefully restore it to its original value so that you leave no changes
> after the check. And I thought about it but it sounded kinda yucky, thus
> the setting of hw_injection_possible at injection time.
>
> That doesn't mean you can't check that variable in flags_write() *after*
> the first injection has happened and it has been set properly, but the
> first injection needs to get attempted first.
>
> At least this is my idea, maybe you have a better one...

I'm bit more inclined towards your previous approach of 
hw_injection_possible
check in do_inject(). This seems better than doing it in flags_write().

Suppose for example, the user just writes different bank numbers for 
subsequent
error injections and does not modify any other fields including flags, 
then this
method might not be helpful. So I think keeping it in inj_bank_set() or
do_inject() is more reasonable.

I was kind of figuring out the best location to place the check inside 
inj_bank_set()
and doing it before IPID check seemed the better one. But it doesn't make
much of a difference though.. So just keeping it where you suggested before.

Thanks,
Smita
>
> Btw, we'd need some error messaging when the hw injection fails:
>
> ---
> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> index 0fd1eea2f754..5ea1d603b124 100644
> --- a/arch/x86/kernel/cpu/mce/inject.c
> +++ b/arch/x86/kernel/cpu/mce/inject.c
> @@ -345,6 +345,9 @@ static int __set_inj(const char *buf)
>   
>   	for (i = 0; i < N_INJ_TYPES; i++) {
>   		if (!strncmp(flags_options[i], buf, strlen(flags_options[i]))) {
> +			if (i > SW_INJ && !hw_injection_possible)
> +				continue;
> +
>   			inj_type = i;
>   			return 0;
>   		}
> @@ -382,7 +385,11 @@ static ssize_t flags_write(struct file *filp, const char __user *ubuf,
>   
>   	err = __set_inj(__buf);
>   	if (err) {
> -		pr_err("%s: Invalid flags value: %s\n", __func__, __buf);
> +		pr_err("%s: Invalid flags value%s: %s\n", __func__,
> +			(!hw_injection_possible
> +			  ? " (SW-only injection possible on this platform)"
> +			  : ""),
> +			__buf);
>   		return err;
>   	}
>   


