Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5503C6E69BC
	for <lists+linux-edac@lfdr.de>; Tue, 18 Apr 2023 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjDRQls (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Apr 2023 12:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDRQlo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Apr 2023 12:41:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6DA173B;
        Tue, 18 Apr 2023 09:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrHjcsy6Dc2oeraZ8/9GTvzaUDbL3e2MwqwMS2S40YDv4PNSqjF9grZ5bcCNFDk/ML0rE6dARW7tMxnMVJjg6dzHQG+2R4sDqxz2bUlkpoRr1g4Zfs5YdAx/tiwwtNIXHmt9bxaogLV/ZrxEXrXokzFsZJxuRQFzVUm2IcrjzP08gmleCp7cELLA8KvZMclH3Kb+aOEMsRPVS5Vghwib87QjDTFCsuhieq2XXJvDzbsQMy+mJq/LVsUViKH4eoC0THQSnFIfpZbPpa1XsCT0uTxhY5L+LW5VZJAkLAK8B4XgjsBX35r4Y72dlRMGrAsUSb6fdXQRx2HA9mTR5ON2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIB7cLlSOpW183kab9NWhCcYssc0nmeivPrf4oR9pV4=;
 b=oQ0M1rebzx2jj+oPGtSZeMprUsO7yOSz+qt1klxXbEkDImIuh2RTIXQK1TLMWi0whepnySyi+ACHi/wuYdNkmSqBU44Ig6/76Bc9zkLo3+XiOg3Z5URLwOwQmX7Z5TYcW/3NyXEuEUkkokRMwDW0LjYshET2BagXSGtVepRHATtEQmcChGrhGizlTEjfVFXUI6R5PnwU7ppbT8uHL6i5zhu5LOvYvhH8wXshPfK54ohqHeTuWxKMjCbd56xFwaCCngvd0YIDCicg6/jZPxX6E5gqgz6ISBbHGCYqkQAa89F3i+QzjXsjGWMqUFyuatJzFDjqEjJ5HcsrL5cp8vJzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIB7cLlSOpW183kab9NWhCcYssc0nmeivPrf4oR9pV4=;
 b=cAnlyPLsie4WDYkOCL1gocaV8ibNEQc+ZVKx4RDxsT9C2hW21Gut6eZRWOdN55qLGpIq/bFBPUxj0bog3SwYBA6P4T5HO8IwpwP+wf3YnAOOYW7e2RPRUVCpTUz3RZZyEfxfeVK9FiX6wuzAxOuMFFOPU5KboXIfHd4TtzfOtls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Tue, 18 Apr
 2023 16:41:38 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2%5]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 16:41:38 +0000
Message-ID: <a5d0c575-ba4f-1120-c7ee-bc37e8d40402@amd.com>
Date:   Tue, 18 Apr 2023 12:41:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH] x86/mce: Check that memory address is usable for recovery
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     yazen.ghannam@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        patches@lists.linux.dev
References: <20230322005131.174499-1-tony.luck@intel.com>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Content-Language: en-US
In-Reply-To: <20230322005131.174499-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::6) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6a044b-8c9a-4e9d-1009-08db402bc772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sme5RZ+249/BEMtJt2UoMakJy/eCBc15mCQ7V+lro3jps2QE5U6TxQR2MVeeM/4ktdxK90vbdH89rEgdTbddhc0eD39pUyAAv/xmboMsSK4kVTTxFa8+Mq69GkZV3SXamfou8eW1rbZnj/WU50p+4SVQYcdo+gZaGG3GkQyfEtSgq5yJH3E008QTPev9LL5gR2nzLtTQ1PYiTiPlsLGV2LmoU3bK2Bm84UNGdLxXED/R2Du2VLZhU3Qk3QSFGMuJ+MJtyJM4VtYUeL3CGkK5zuQUiDQFwaKlB2Zamrc8jb1djZKY9B30VKaBIcTPhtsoGUNVJbBXOkO40f2i18HT8XLqaGpQ6yZP56sNQLkEI5a4StJ+lV8VZhbEtSyHsxg1nkEElL5Vs9W59zT0+QmKQTcTgR2F7uiCQIAzkGoL26Wn+fkQibWDptvMVvb62ctjsYqtNib2h0zzg0KXOzCeJXybc5iXTN1CFVRRCwloCRXxGqhugrD8kV67ZmztdCiQY0FT6OM4jHoBgPQsXAOUjSIBsO7cuTGjsF2kXv9h/MbJP+jNzj5ZjEtIMkCqd5N3wy7P8oHYTkYruyvzMVe7GJLywOvCtFhTTJtztMWqp4PDnwD89juFMjYTJK2mYFLUt5bmt4L4fv8CiwRCAktGEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(110136005)(31686004)(53546011)(6506007)(6512007)(26005)(186003)(83380400001)(2616005)(6486002)(966005)(5660300002)(478600001)(38100700002)(41300700001)(6666004)(8676002)(316002)(8936002)(86362001)(31696002)(66946007)(36756003)(66556008)(2906002)(4326008)(66476007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTF1SURFMk1rc1dwYnJETWtVSjZySW9qYWdqb0s4ekZxVkx1WUlBUXpXajZv?=
 =?utf-8?B?dHpXWlBOWFBuRGVHbUpQS1E3QkVzVjhrM3RDdVR2TWR6bWpDUjhjTGRRSmhi?=
 =?utf-8?B?UkloYWFZLzQwNm54S09hNCs4QXQxQ25CejZieFZZbGtJVitzd1N3ZU41VzNG?=
 =?utf-8?B?aVFZS2dsOUpFU2hldDBkRkJpSjY3VVRIdGdla1Bsc01OYUNuSWhJSkJZNmcv?=
 =?utf-8?B?NDZDM2dpaHRqZ09CTHVQVlRCR2hXUE4yV3IxeUcyM3M0c0RlNkhOamZqUHRy?=
 =?utf-8?B?SitzU1ZDaW5vakJUNGZ6b3EydHNkSmFmWWhVNFhQTzU1ZlAxMjVZZTdQODRa?=
 =?utf-8?B?TEtIcWFHT2xaV3dMbk1DejVuRDdMWjg1bmJaQnpoeWpYS1FPZ0lLd0FZc2Qr?=
 =?utf-8?B?RERvRUpmTXR6a0lhSVRRSVJacm52aU5MVitlMnNnaDJiaWsxUlowMTcwSUhy?=
 =?utf-8?B?N3kxQmt1eXpCZnVyVTVsYlM1RitXcmhsNEFFQlR0Z3Z2c3VqQWRxWE45b1Rj?=
 =?utf-8?B?SDdTekZpWGcwRCtxYW0yNEhsWUxDUHB2NXpJTDlaZW41MW9BRmJKK1FBQzBI?=
 =?utf-8?B?VHorRmg0Q2RFQjVjeVk2WXRPd1ViOFNMRzZwZDJkVlE3K3owZGNXMkxyNm1N?=
 =?utf-8?B?UWljenhMVkdsb1IwZlA5SWxZYmNMSDErMDNVOVNGYlRycHVxYm8xSW5wRk9E?=
 =?utf-8?B?VzhiUm0zbmlqTVg2OUppek51b2wxVjZjcTV5WE9uUFVjS1kreG1nSy9BOTBu?=
 =?utf-8?B?SEo0MlB3TlQ4T0VHVStaUkxaVFRqN1A5WlVFMXpsekh5N0dZNzFZUG5zN1Bl?=
 =?utf-8?B?N05wbXFiMWZPVHlES0pJdVpsbFhURXRTa0FCQUwrRkdodWJZcE5aQ3RHT2RM?=
 =?utf-8?B?SlViZmRjNmh6OE4wNXdQQXQ5MFlzK1dZOHhpVUhFVUV4VlVIN2JwTFFnMTJq?=
 =?utf-8?B?VjF6V3VPU0RXSnEySk5HZDIvVmtQeUxqMWxPT2t3NGFmSnlPWDc1TXo5N3RO?=
 =?utf-8?B?SnlhUlQxcTFMdm9RUVdWQkJLbGpmditJMVUvV1NWaGJwN1pjWHB0QXo5bGhi?=
 =?utf-8?B?R3FQOFNqelRxQkxZU1RreFo4Y01DVjFMdTJpcW1WTFNweUpnbGI4N2d2TWR3?=
 =?utf-8?B?Znh2VHRrMXF4VWdFcmV3QXdLd1lNSmE2ZHM4MVdVdVg5V1cvL0RKbXpYSDJV?=
 =?utf-8?B?SUcvSXlUbjJicTd4cit3THEzV3N1MmFvQkhvOGI1RzdnWnVacWxEM2xjWHpG?=
 =?utf-8?B?eXNzTUZaQTg1dDdBVWpMTUw4UmFJU3F6Rk9BcEpmaTNqMVVDWWdKb01qZXhB?=
 =?utf-8?B?SHEzSXVaVWZqa0w2d2loRmVoZGpqK05VTjl2dUtNeVU2N3hvVnJGUEx6aGFO?=
 =?utf-8?B?dHVCeVpxcFh0Q1FzZW5RdTRSTHdqTGNCWWdCc0dyaTlFSjBnbFBPc010WDRs?=
 =?utf-8?B?YzNnak5waTRHS2R5Qyt0cE5FempKTjZqbjdob1EzWk84OEhERHdnRWdMVVdn?=
 =?utf-8?B?eWVmTmlydkl5Nkd3bjJjbFlLQk5xa2VHRjFkbXMxU0N4OGo2MCs3bkZ3anpm?=
 =?utf-8?B?UkYrck14bHI1ZlEzMENYVmgxVEw5cTh5ZGxqbE5ZL0dGSjg1bzhQOFAwc0Ft?=
 =?utf-8?B?ZUlMckpKM25KN0c4RElRNHRyNzdPZWc0Q2hBNVJ4WmRzRkM0eldvbVVBaU9O?=
 =?utf-8?B?b3YwWCswUVhPaFZ4WFp5Q3RlQWFlcld5bGVOSUNIek1RaUlTVEdQN28xemtm?=
 =?utf-8?B?aHI3U0k1MEpOc3BUSTdrL1B0SGZvbDFoM3ZLaERhaTB0NGdaWExicmNBL1ZQ?=
 =?utf-8?B?T1lsTU50ZkI1Snp5MnRsdDlYVmx3K0Y4SjU1MTVuNXMydlNSRmZ3ZHNuVnFo?=
 =?utf-8?B?cnZnZkRZV3EyMGE1enNsVTdyc0ZUcFJVVnVVUWVMT1h5WnBjejQzSGxXVWNn?=
 =?utf-8?B?SE92T3Iwd3FXblQ1dDFCL1FOaTZGNS9EcjYvQ0JDVlhHdDlXUGN2Yy9pbVpr?=
 =?utf-8?B?L3lBK2taMk1tNXQwOW83Z0RSd0E2WnA0dzBFWTJmeDIzOUtIcmtUaUpQcVJE?=
 =?utf-8?B?WW1abythc3ZIYldzaEZCd2FXQWtRaHF1Q1c5Ni9BZ1ltK2h3NVZtbkJ3a0Qw?=
 =?utf-8?Q?VrnAsyqOb/Kzauh1ntkA0DW1H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6a044b-8c9a-4e9d-1009-08db402bc772
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 16:41:38.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMUSmYtTBbI7GJqtGBOIufIs6xd7pty+TdNYtX3AId2C23qm8sBccNYlAVi7Gaz9mgpfc40VmADXbeaCYrl/sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/21/23 20:51, Tony Luck wrote:
> uc_decode_notifier() includes a check that "struct mce"
> contains a valid address for recovery. But the machine
> check recovery code does not include a similar check.
> 
> Use mce_usable_address() to check that there is a valid
> address.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 2eec60f50057..fa28b3f7d945 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1533,7 +1533,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  		/* If this triggers there is no way to recover. Die hard. */
>  		BUG_ON(!on_thread_stack() || !user_mode(regs));
>  
> -		if (kill_current_task)
> +		if (kill_current_task || !mce_usable_address(&m))
>  			queue_task_work(&m, msg, kill_me_now);
>  		else
>  			queue_task_work(&m, msg, kill_me_maybe);

I think it should be like this:

	if (mce_usable_address(&m))
		queue_task_work(&m, msg, kill_me_maybe);
	else
		queue_task_work(&m, msg, kill_me_now);

A usable address should always go through memory_failure() so that the page is
marked as poison. If !RIPV, then memory_failure() will get the MF_MUST_KILL
flag and try to kill all processes after the page is poisoned.

I had a similar patch a while back:
https://lore.kernel.org/linux-edac/20210504174712.27675-3-Yazen.Ghannam@amd.com/

We could also get rid of kill_me_now() like you had suggested.

Thanks,
Yazen
