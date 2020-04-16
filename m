Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75671ABBF1
	for <lists+linux-edac@lfdr.de>; Thu, 16 Apr 2020 11:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502830AbgDPI7j (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Apr 2020 04:59:39 -0400
Received: from mail-eopbgr760077.outbound.protection.outlook.com ([40.107.76.77]:10503
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2503105AbgDPI6d (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Apr 2020 04:58:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHt+EC35ZZDXkiOZizSHp3c4NkCt+XKL3bdAjg7orEqwDj+EzZleLLoRa3vBZ600OhDcL3vVYCriiEeUTGDFEnbHQNOAygkn0nkVaiypcq4NmETKgJ3/aKXgGfUV6pPKx5/5Npgd6v/KD1nVq2QRwZghlUaFLRL4jeLbJH91DGG2wuBAI28fJC64LdqCkzMzMVQiWBqBzA06mecaM4NCkd8jlJ7M/IcrWQwjJAwOnUxNQ+pwyguiMbB7Dtb0rOCIfl/6McKclF000DLjPvElBL7B2EOVqlWlL7CfECtpY1sgldzEtibmwd9g28ldIKEeNNFl6HZNvec0FOaXI/WJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUa6IAxx9gfP3sjKcKWh/Enms00gOXBuG8eD5elwhmY=;
 b=KbDAaSeev//msgPTG89gWHjK8NRxOvaYjQxcJr5ZNvtfGVun3lkbJNnWWYfaart2UQx3xIYgdElmMK3B816ju6EHTSY70k7Ei/FgDuMYncGs9NlS86cQEeAISOPrj2c1pykVG39gVsKWJcAx2DmIxCuU5wq1bbEfA/vmUfXgNrlVxVc1QySHUGSz0V/o39hHakrfLGd9C5F/InUQmacWhM7rmL+0IXKHLFRCciumcTRCjRx7aVeRCSJ5y1Cx2BL9HBGUE8D3zOY2HGYatMcbNzkFHBrUmjrI8JnmPMYNLGOzpGi0i+yDLcCbjglpV3UxVqyHA9sP5E+5WgfwlrPSQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUa6IAxx9gfP3sjKcKWh/Enms00gOXBuG8eD5elwhmY=;
 b=GGEYxj99jZZDzvljwc8rCZJEHf288yLT9tcyng8FJKi/T33qJSk3Jp89Ov84Rx6ZFMHR+cJykPWymxm1tErs6TEq65dIa9LY0UDinzGiC0ZaqthxiQ7r/MBMYERcrUWmE+dYerA8RMgI05+794ZKKwaFMOKmSel4lNtfgpNYIzQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB3373.namprd11.prod.outlook.com (2603:10b6:805:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 08:40:41 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::75b1:da01:9747:ae65]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::75b1:da01:9747:ae65%4]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 08:40:40 +0000
Subject: Re: [PATCH] x86/mce: Add compat_ioctl assignment to make it
 compatible with 32-bit system
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1583303947-49858-1-git-send-email-zhe.he@windriver.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <1f449e01-3207-b699-b91f-d1c04626a447@windriver.com>
Date:   Thu, 16 Apr 2020 16:40:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <1583303947-49858-1-git-send-email-zhe.he@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK0PR03CA0116.apcprd03.prod.outlook.com (2603:1096:203:b0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend Transport; Thu, 16 Apr 2020 08:40:36 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbf12f03-102f-4656-6b6a-08d7e1e1d80c
X-MS-TrafficTypeDiagnostic: SN6PR11MB3373:
X-Microsoft-Antispam-PRVS: <SN6PR11MB337346E3AE77A5A0F3124CBB8FD80@SN6PR11MB3373.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3360.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(136003)(376002)(346002)(39850400004)(366004)(66476007)(66556008)(5660300002)(186003)(66946007)(6706004)(478600001)(2616005)(52116002)(16576012)(86362001)(6486002)(316002)(16526019)(6666004)(26005)(53546011)(956004)(36756003)(8676002)(81156014)(8936002)(31696002)(31686004)(2906002)(78286006);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NgRsP7Cy6CX4ReN3ixZyEPD1HCEKFwmjGCjADM2N6ILhgZja2xaLjkZBSI7djmvvUj5xTzCx/dSspwLYLatB3Hm64UL/bdTMfDgaZPYXvBP96laOGkTcypuaQd21Ah+OBF0LzdCTiTDCHKDQYvMZTfBDSH5ZeDH8ymcs3rtnU2rwp16PgPjyCr8RdBeOvOWnbQk1Tm5kUDS0VSjeC5uJlhkBPGB2ssGfngKXkfxgzVbw5DZDdxjcZ+DzrU0PTukdsthWb+t1imWSEp9L51fydSbwaZOpOiSJs4nnmfqBMIZcidzKc8WpjoZPKfjISjVAS6LWeopkZy/5/8x7bwycCkGHEXrMDaca7DzGMQ1XtCcTl8VQp25pzYUV6BjwAey//s+SCUKjtTtr5qDdv7pXN+yx++3paa+asp/jO9d68bvDRi7IfhBsgO3p/34pGxwckoBcdXhozbAfvurp9yRSkXhKMbCbXbb909Y5a7aMeiNEx9nQM1Z+38YzHFGwsyyfC8INsXfBO8/3/tUCQ25BAUqQgzCU6m8Tm9DUcJ5Wg8=
X-MS-Exchange-AntiSpam-MessageData: VV4xpqTXv1e6lFf3rEDRZDoyM90er7QWcu1rQw4aIRDg2ketk/le1iddSS4Ydr7rB523JsOoE3r/h9mpoXwKrn49rd+pkrCtlWfw6bn/qYyBgn82Gc3gGnX2tgTrgDq7nweYSdzooLPTA90auewDFA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf12f03-102f-4656-6b6a-08d7e1e1d80c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 08:40:40.7087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTDZFF7+PqR2M7hmBrH9JHCUh/0lHkZfPbLm8deFLL2TJrEIqdC0TL3MhteMlNAChoKv1CCwD5dYp8beFOkshg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3373
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Can this be considered for the moment?

Thanks,
Zhe

On 3/4/20 2:39 PM, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
>
> 32-bit user-space program would get errors like the following from ioctl
> syscall due to missing compat_ioctl.
> MCE_GET_RECORD_LEN: Inappropriate ioctl for device
>
> compat_ptr_ioctl is provided as a generic implementation of .compat_ioctl
> file operation to ioctl functions that either ignore the argument or pass
> a pointer to a compatible data type.
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  arch/x86/kernel/cpu/mce/dev-mcelog.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> index 7c8958d..6c9b91b7 100644
> --- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
> +++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> @@ -328,6 +328,7 @@ static const struct file_operations mce_chrdev_ops = {
>  	.write			= mce_chrdev_write,
>  	.poll			= mce_chrdev_poll,
>  	.unlocked_ioctl		= mce_chrdev_ioctl,
> +	.compat_ioctl		= compat_ptr_ioctl,
>  	.llseek			= no_llseek,
>  };
>  

