Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA031F521C
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jun 2020 12:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgFJKSu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Jun 2020 06:18:50 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:55968 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726533AbgFJKSs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 10 Jun 2020 06:18:48 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05AAA41q013149;
        Wed, 10 Jun 2020 03:18:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=nPBDhy/T2tDXak+DG4xFo+yfCpfpaj3EYLwAMHKOx34=;
 b=wH/wmJ7W8fhwg1yDC7+IzSA/YXBHttaRG6fiylu/TCo8IN6VeV/Gqq4zqIYXi0uenIxi
 oDyC9u26NpaZAUo6LkN3uHy4gnNJq10MeLQl8eA+ESXyR5Cw90x7DyYPn/ox3URjC8dm
 BtwfDOuuygm7eP/+5wsZ8X3x7gzgGu/3JwltcWI7Hw1sD1EwaTBXYnTIYWS5okqenR1u
 8gEdY+G9zmDwqkJ9sVKq/UIBH4zcvcCw7P99F4dY7AnLPnF09CSDSwdFJnC4EDPoiJok
 lnh3/CPXziU1+XL2qnTTK+Z9w0zI4+uDjqLSM13J3y+AVrAEYSVZwEhQFUvJmDs4QYVq Xg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 31gannd96w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 03:18:31 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Jun
 2020 03:18:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 10 Jun 2020 03:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leKidwRzaXBd4JTH9XGGnQ1K3w0P2zIHuKaqkOKDLvejAiJjMpZ2ofCRQlZKWzsBZc0fdZfy5ToS85KKQydiByWc+yGMMsRP1Usf3YYBoIHIucveOpNHoM2VcKNNHBIMpAXgQlIL5BfSe9cpYPv4WtATGYAK8IX2c7MfTj02+AjDfpNEwmeyyA0XIVxE73k3XidasOGzoYHSeNIVjzXqkWU/dxgRJk85jFcv59Zu4Eq3Lww2QUbE/mj8LbQk8axETfxRA80E0AhjTTyII48P1nyfBm2QwClIcs9Lmo7CprmQSFCn+G76Koa6BOL594/mM5N/3ThTqWAqddR/Snc/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPBDhy/T2tDXak+DG4xFo+yfCpfpaj3EYLwAMHKOx34=;
 b=kCPoWaqMGx/+rf1e5ffDmd0E+e/RnMgL653C+ptn6Um08e8mja7xA8h6pjv/DYiO5OlUZaCFXv5+POn6ymh1kFDABqls05cAiDMWxFBuzUL9jiMZheWmGXyOWDLr2LauSTkzLxDHPiANu/GLKZDdHpLt11SA1udewXetmtONDT4apOVL+qCQvozNc/j2wdxsrYI/MxkXpIhnfAroACkfyvcCxctE8zwDf7vfNopaNeBehoZdXl2HT+M1UPdSvURS4bKQaS0VdwxcP628uiGv/rKyil5SDezd3cWvpzAs4sQH9uYmslf4wulmd/RnhyH3zbLPeWzcxCwJpwJ+6oBIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPBDhy/T2tDXak+DG4xFo+yfCpfpaj3EYLwAMHKOx34=;
 b=rXEK3FufU7Pidg5CcDO9sHqtnenOPK0DRsetof5xeUjVnstHlASDAsaypx3oGzJhX/zHBx9h56CCVAQUpz3c3FW+QfgnD3Wp6k176wx2dPUSOCh26HbzfuPDK4/IDYdaSTxA0LsNJwU5SXkaTAEQmtwrd7+VDSiDmHClh9obkg0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2408.namprd18.prod.outlook.com (2603:10b6:a03:12f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 10:18:28 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::5d5a:a759:2bad:f8fe]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::5d5a:a759:2bad:f8fe%4]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 10:18:28 +0000
Date:   Wed, 10 Jun 2020 12:18:19 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <tony.luck@intel.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <james.morse@arm.com>
Subject: Re: [PATCH] EDAC, {skx, i10nm}: Advice mcelog that the error were
 handled
Message-ID: <20200610101819.oa2ivjtxildwothl@rric.localdomain>
References: <20200610065801.3579-1-zhenzhong.duan@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610065801.3579-1-zhenzhong.duan@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0301CA0012.eurprd03.prod.outlook.com
 (2603:10a6:3:76::22) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0301CA0012.eurprd03.prod.outlook.com (2603:10a6:3:76::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 10:18:26 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bedb116-0d0e-472c-7b8b-08d80d279e37
X-MS-TrafficTypeDiagnostic: BYAPR18MB2408:
X-Microsoft-Antispam-PRVS: <BYAPR18MB240880F926A0F3DDF3A46253D9830@BYAPR18MB2408.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XWWDQqyBo48ZM64QWZexdx2/u5O2khYVTZhCSXirrpNCCznyGRicILDylY05fzUNjysHTe9wBwmORPJHdEuPYoFVYA69kLsYOktFhdfjvH9A+E60NrfsafHKie8TbtOOpna9+VRriIfsheJtTo7FIohERZGygTycTWFEcjdFPhdt3lZL9XAqBkO89E7MsBnRypVtnX7dFguhdurGd/qouFdNOlJEY9LRpnARbmBB61ZeBpXdCoBMCJ91R4dqlNMr7M9i2nnAF4XNsjRGOibZ2GDKAn0/tfgnafG6doR9SWnchoZWJC5QG1HxhaBj1dCjqwJuA1stSOvCjUwwh2zMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39850400004)(396003)(366004)(5660300002)(53546011)(6506007)(66476007)(83380400001)(26005)(1076003)(66556008)(6666004)(66946007)(86362001)(52116002)(956004)(55016002)(316002)(7696005)(16526019)(8676002)(9686003)(2906002)(8936002)(6916009)(186003)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Y3jGL5E6U1nQN7gIPceAHwFWzD7zIE2+Lpq6+/Wlc7Kk2zd6uCntD304iuQvGcY/dR6k1JwNVnsU1jwwLt1dOvrKQz8V72eYwXh8Fmx48POFjUrp4DGGNGl4Ggi9y7Btxj6J5KcqQtUDsr0ImqtsmyITCgT0OFGWAYA8mhTXZELBOjjHH6r45Sx0TX0mWk15Lq5vkGP1+7vNiLeZDyTGJNqPGLRm8BULvZjRnWGeIzxxZvjxiWUfzGh1hmyelYNr2+CiZccB8iOL9gd5826EpmesvM7VLeILtKMhMUNnqAfcCdGG8VvRWubhui6CYUZOSOsN0N6T1p0z4G9bk63WO4Rliv09z+VKF80HiC0AIjfZej/qrUZZ9QeZ603HLxcLisj+P4fuYWnQzp19ZkQfHhnKTDMGQyRbUYc9j3wK13/baD+n629D0wx2dWT0+bKKZEE+2FYB0beghHQgKNg9WHzp/ga1hwTLCJppN67/pP8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bedb116-0d0e-472c-7b8b-08d80d279e37
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 10:18:28.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rb0b+PVGh8Sk/WGOcbzXyeeYPAHbatbXaFv5sEgvEsFapigkJQsEsMuTZDNz0MGjcHahV1lEXHkV3cp3KkaaYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2408
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_06:2020-06-10,2020-06-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10.06.20 14:58:01, Zhenzhong Duan wrote:
> If one MCE error has been processed in kernel, it's not necessory
> to pass it to user level mcelog.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>

Reviewed-by: Robert Richter <rrichter@marvell.com>

> ---
>  drivers/edac/skx_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
> index 46be1a7..8c0165b 100644
> --- a/drivers/edac/skx_common.c
> +++ b/drivers/edac/skx_common.c
> @@ -615,7 +615,8 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
>  
>  	skx_mce_output_error(mci, mce, &res);
>  
> -	return NOTIFY_DONE;
> +	/* Advice mcelog that the error were handled */

... error was ...

And make a sentence out of it, so close with a dot.

> +	return NOTIFY_STOP;

This change aligns with other implementation in:

 i7core_mce_check_error(),
 amd_decode_mce() and
 sbridge_mce_check_error().

-Robert

>  }
>  
>  void skx_remove(void)
> -- 
> 1.8.3.1
> 
