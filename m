Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C455A464
	for <lists+linux-edac@lfdr.de>; Sat, 25 Jun 2022 00:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiFXWes (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Jun 2022 18:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiFXWer (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 24 Jun 2022 18:34:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D63E53A53;
        Fri, 24 Jun 2022 15:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iscbVgrb57gLPDRAOVRn0QDxb0k9tPl8xR0AxXSCa5MiwdIks04ZlwiXOW/YgsjUZo4vS4WOGF3x4tAvD0gf4l8G/8topqt8IZ9i3d1X7lt195XiwbCYxOpgyEeyY6wjSkekdAKhUV+dBnch3DLQKGkHcOClO0TYZKWUTFPSHRvXRjnFhROHfyxaAs3A3p4FG0h/QIKl/vtlJ8NlSz/zZDrItl2wgeC+v+7VHgIza5F10eKNdfkaApLN3t9+Wf+Ye62dHhlsoK0nOJNT4fC/9kCCDu98lNZsb9UBu5A14VfgTZ3pvinGQQE/RFn7UKNZ82Vqybip+hKppukGTRz9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2FmnrN5KQD0GJVgRw/tnbjbq6DUxveOfTtd9pG/vQg=;
 b=oaMSFug1wvlvWlZ/Bpc7rkgUYYuVz71cHTpKzFiLUNX4d+MT2/IXIcuoBbURVMdWBBDrkVOx7yq8ORVxhDBqObjkakHlRkiqxXQGn3R5H71dB+j/QqxCTsVWTXLDNzKvLzfPLkcCAKMTzupKo/Dkz5NSZUCoWxVby19dRt0eweexrFgcSH41rshqEYSC3lnxM2fFVzzenE4xDz+8qBmh/VrI3tGVactW9iWbSnN8EgiQsimR/F9wNRSV2xofUS47r5ctnNRPAiJvbVSh3OLNLs9hMl7SooA2s4I90GcZslVrmHnPskUkyiNsKLFeV0vNeYOve3hyZCXhXIvbHELTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2FmnrN5KQD0GJVgRw/tnbjbq6DUxveOfTtd9pG/vQg=;
 b=GMh2G4hMeDPUYez6C2gmpPv8ARjdFCh3aEL8fftFnpQPNWp7tE1ALdFJWvf4WHklLKCynnDzNnsigldhIZCkudtdrxYnsz1nuOF38bsUa1lw9AZNVNkq3t2ka+CEtk7Uy7t65hChIf1sCRmfTN9RSJ+3RDJGlvoRzI3nYg41a6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DM6PR12MB3884.namprd12.prod.outlook.com (2603:10b6:5:1c7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 24 Jun
 2022 22:34:44 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9dbe:b7ea:e0a9:6c08]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9dbe:b7ea:e0a9:6c08%3]) with mapi id 15.20.5353.021; Fri, 24 Jun 2022
 22:34:44 +0000
Message-ID: <d3f554b8-4fc5-efe8-1ca2-aa95c7e76eb8@amd.com>
Date:   Fri, 24 Jun 2022 15:34:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5] x86/mce: Check for writes ignored in MCA_STATUS
 register
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220610192515.98540-1-Smita.KoralahalliChannabasappa@amd.com>
 <YrNRYJx0CNDNj3oX@zn.tnic>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <YrNRYJx0CNDNj3oX@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c5cc932-7156-4a13-5308-08da5631bc7e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3884:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 479ShtpB517YyQD19aQLEP8x59rf25ENc1cBtCNlYRFO0geBESupgrFYDw5Qdq9lwaLWa39vOixWoE9FnulHfb/1ErEx65v1+OxmrW4zV2HD3BylmP5OofypkwIUVwCXesoYiWsf8I98+aEv2go9W8CDl3VDp+y43tasyLZlzPEm+vUt2isBT2g0u+ubf/79ijur0VQBjQp4UEMzily63FJugPk8rNSHK8fXKt93Wh5OPhENxLeCMcTitf7gfi3o3txBe7iaAJNIMQR3qlU4WrPeai9tkMq5iFMzxluem8mBUoIiv8bgR/T1NBv2EDtHJ/03suQuYQuBeVX29sqTw1XMYa9YxW98EMLV8XxyleLt+0WEFacwFSBpoHwrZgedolHVU7RH+Dn3IwwHGxvuM77SIxCYxyFDtOn5sUqabpJR7rYHmfYzybF4/HV08LhT3Q3ySp81/1NxLauPdaZQvaLwTk4IxkqQsLppaRtXX1q8Y2AP2BLWoO7c0cGY7JEgcAcRsULUiXTtQl1t/Rts3YDmFNhf8WeyXslLRXjJIZk+vYckJsbFgthsC0ISNu5EoJ6rDnr1MV1UEFgFOpLX8osuePcCsPuV48+Lkf4MwO+EicGLzbDdfwYrJP7yMmL5X5KoDD2zXAI7L6FIRLFmkSpCV8Gs6UJ3DuMq7SD2Z9KLVPxZZWgwCgRDcIIvSEOevzUt+0a5X/3pRde+zisxoBmuldeLZnr85dHPGP/FJoznmEKmWYdQ4Nb5zpHnPCDedEpCtKh/Zoys3l6a9BrmtsPrQ8dxaPFO2u8M9a95wfu5Exdbwm0WDH373EsR08qk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(31696002)(66476007)(6506007)(53546011)(6486002)(86362001)(5660300002)(66556008)(4326008)(66946007)(38100700002)(8676002)(6512007)(41300700001)(6916009)(478600001)(54906003)(316002)(36756003)(2906002)(186003)(83380400001)(8936002)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm11SXA3MTBsM1ZSYURTdFZFMHpJZTR6U21XU1dHcE55V21rMFVFMlBlU3Jk?=
 =?utf-8?B?N3ZTT3B0bkpmU1Y2Y0Y0N3UvYVp4U2UzUE81S1RGZnk3SERJZWtHVk5EOGZm?=
 =?utf-8?B?OWFlSDRYY1hvcTJ1enpmdUR6b1RJdi9ZTnZFWmFVOXlVMUNXZjMvYlA0NStR?=
 =?utf-8?B?UURvWUZaT3VNQW05RzgrS25sRTJnT3l4NkcxTUV2WGEvMWgvM1VXZDZHM3hx?=
 =?utf-8?B?ZGk3c2tCeWZyVEU4TWh2MXlJck1wcElXR3BCZUIyY25BaGdFRW5XWDNiQmlX?=
 =?utf-8?B?YUp6TlpGZXNzcUM4UDFJTG1sc2ZZTXIzeVkxQkExZnJFU0QzQmNVZU4yMHMz?=
 =?utf-8?B?KzY0aTZiUjZ3UnJFbU5IVnNqN3IzRTduMGdZVGdqbVd1TnlYbnYreXlFWUY1?=
 =?utf-8?B?V2N1ZkFYV053TDdoZ0lmaWVMSlR0b3VEeWJVaWZKM0NhaU52RUdGc2hCVWw3?=
 =?utf-8?B?T2F3Y1NQL2NEVHdwdkdlTFVwV3B4cWsxem9pRnIxNFpCOWdMTmM0dVM0Y243?=
 =?utf-8?B?ckFPY0F1bnRnOE9ESERndkZVOU1mUW0rTk9OVmpGTXJ3cGtETW9BZUVtZklW?=
 =?utf-8?B?dDY0cUxGOHFycnpzQ1pSeG81NDJ1SlI2UHNrcUVscy93V1Q2Z0ZnN21reUdi?=
 =?utf-8?B?V1NGMDlRYkdVTXJiTklCZEtpSHlSckd6QTR6cms4RGdFaUY0dTdtMmJ6VGEr?=
 =?utf-8?B?aDRxeW5SUkxHZC9RSjBTSnJ3NzJRT1NReVUvWHM2eUc1WGNJVUFXZ2d3Zzgy?=
 =?utf-8?B?STNCcFJPbCtvRmJnMGRtbjRsR0xERktpdmhrYWpyWUFvNDZDUk1tUDJobE9v?=
 =?utf-8?B?RVpDUnpSVXVUQVcvc0dYSE8wM1JSRkhsRmE0YzF6bXFvbGdLYjhnYXV0OGRQ?=
 =?utf-8?B?QWI3SW1ZVFdOTHFLK3YyRTZ4NTJsRzV1UDNXTkZ0Wm1ScXRvb3pHdU83cFBi?=
 =?utf-8?B?eTcrdnVOREZ1aXNCWGpvWTZpNnFxY3FoNlFob2M1OVFCSVJtU05rZ0FSRldn?=
 =?utf-8?B?OXdnM1pJaE5pUmpvNHZqbDArclphZTFLUk16RHBIcU1udkI4OTY1cWNBb0N6?=
 =?utf-8?B?Z2x0enZ5R1NkR2lCT0I4NHpQc1RHTWhGWThYVmNhMGxxM3BDZExzckpaNjFT?=
 =?utf-8?B?UnkrZm9XRkNIbCs5eklFMHJVcW9UUVNSTmhaSzBHbnhXaXNGS1lTVUlKNDR2?=
 =?utf-8?B?K0FHM2paSVQ3N2hqcmNrend6ejFOWlpkc1lGY2pvOVFnelBLTTdpcEJYUk83?=
 =?utf-8?B?dHpwSHowbld3RG1kaU1hcUF0cll6WHB3bWp6Q3ZpeTZyWUYzOVBmS0U5cTJS?=
 =?utf-8?B?UXY5UVdrb2l1UlFBeDRxR1ZrZk0wSVZxajNrdVBzZElhNHEyZmx1QUxBcWNx?=
 =?utf-8?B?NnY1b1hrZGdQcFgxckR4WmVXcFNOMFJpcFNUMHlQWEhRMDRDMU5RZ2NuYjJi?=
 =?utf-8?B?SS9uYXRjV0g4ditRNHdib1oxMXVGQTErQmNDYnEvQm02dER0ZitRYlZkSXk1?=
 =?utf-8?B?eVRqSVpnazE4NWRTYXgwSVhXcElvekZENUdBbG9lY0d0UzM1UHcwTE56VDZ2?=
 =?utf-8?B?ZlozQWRGa3RxWXVUUDVqRWp0dmJhTElOWTdvWmx2WEhQcXRQQTRQdUtEUVN6?=
 =?utf-8?B?ZzFyVFJmS2NsL1VqaW9vM04wcVpIQnpvdUQzN0VxeFBYMmNwbUdPcmRsd3Qz?=
 =?utf-8?B?K0t4WlNYUGRKOC9KT2dXTE9pUTRpTWtGOVVnaWxnUDVKR2h0SUhFeHB2aWtB?=
 =?utf-8?B?YmRZMENrVjdJSlFOTnZHaHJLaktlY0tpaG5sVVl3NnhBYjQ5OVhTUjhVY1Vx?=
 =?utf-8?B?ZDdpa1E3a3J4Q3BFWnVlWGppcVNYQndoZWJjU0llTFdVZm13UWRmd1g0d2Nr?=
 =?utf-8?B?WXFSaWx1dTFkU2Ywd1dvQWhvaERwcmxpSEZzbzU2d2pHd0luOGJJNkJRV2xD?=
 =?utf-8?B?MlIzU3Zncy8ydmk5aGt0b1hoeFVCYXdHRzUyWGNUM0s1NUlheGNRemhHc2gv?=
 =?utf-8?B?N25OT1YwbTc0WHYvbWdXS3FSQU8rdVFCbHM0bXg4dkZ6YmdTRHdSVkVWMVVT?=
 =?utf-8?B?TmpxVHpuQkVSeVNSYThUcGtIb1RDSWY2ajVtcG0zd2lJQUFtcVNkK2FVbFVx?=
 =?utf-8?B?V0Q4TzRiYURoNnVhUzEzZXJ3RVNmd2l6UERCZzVoZGRJMmoyZ1Q4aGV2dnFy?=
 =?utf-8?Q?ItQf7xfRnCkZoMcSDVjTQagMJdQbrWiN02nGQZGW/Lot?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5cc932-7156-4a13-5308-08da5631bc7e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 22:34:44.3221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K29kp+FGpQrGUT6cPP+N2y/qlbdEbbzacN2Ysppo6lxKHaQNTxJgQxSmALva6PkRFc/KEl3OHh/eVn+rsTM/bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 6/22/2022 10:29 AM, Borislav Petkov wrote:
> On Fri, Jun 10, 2022 at 07:25:15PM +0000, Smita Koralahalli wrote:
>>   arch/x86/kernel/cpu/mce/inject.c   | 50 +++++++++++++++++++++++++++++-
>>   arch/x86/kernel/cpu/mce/internal.h |  2 +-
>>   2 files changed, 50 insertions(+), 2 deletions(-)
> I've simplified, improved and removed some stuff. See if that still
> works on that platform which ignores writes.

I tested out the patch. Its not behaving as expected. The module fails 
silently
again.
> +	cpu = get_cpu();
> +
> +	for (bank = 0; bank < MAX_NR_BANKS; ++bank) {
> +		u64 status = MCI_STATUS_VAL, ipid;
> +
> +		/* Check whether bank is populated */
> +		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), ipid);
> +		if (!ipid)
> +			continue;
> +
> +		toggle_hw_mce_inject(cpu, true);
> +
> +		if (wrmsrl_safe(mca_msr_reg(bank, MCA_STATUS), status)) {

The wrmsrl_safe() doesn't throw an error here.
I think we need to read back the written value and check for it whatsoever.
What do you think?

Thanks,
Smita
> +			hw_injection_possible = false;
> +			pr_warn("Platform does not allow *hardware* error injection."
> +				"Try using APEI EINJ instead.\n");
> +		}
> +
> +		toggle_hw_mce_inject(cpu, false);
> +
> +		break;
> +	}
> +
> +	put_cpu();
> +}

