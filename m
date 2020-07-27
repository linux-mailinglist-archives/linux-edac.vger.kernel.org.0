Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE5822EE01
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 15:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgG0N4m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 09:56:42 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:31854 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbgG0N4l (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 09:56:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RDjd9V008094;
        Mon, 27 Jul 2020 06:56:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=6kdNVcejQfZB+AZBDRPMTsJ3cfJ4I6ZCbLQS6KxETfI=;
 b=Zu/iflYmsgSE69XCQQQKDuPvs01EVP4tyMGYtZIJV47pAlnE4CC2617YK1Z489Av3Cgj
 oHmZCppHnM/JEMuCvOyCiCVoixYwW9v5wQFMEe/mxRTiV0kdkQSB84kK7h8NJQNqlaCv
 rdnRK7Lhj2xA6Odxk7Vp8NshDPAu4MdMbGAM4faOo2e+2ndz0mA2Mwl+7eyeOLGo9Dx4
 Y2ZJf1ohlqrdPbyUGeAzKyhZGwT58Q9XK26idVmY27Xh/4IQXwi0TxZzZBbxOkLv2m4I
 V9CP6cOCtBHIU7GnL4A2SmkbzqYiIXZlMlam3OXHUq4sb7dzAWve1cja82uvI0BUO9Av SQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 32gm8nex5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 06:56:24 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 27 Jul
 2020 06:56:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 27 Jul 2020 06:56:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wuyz4EICnjlsImrGDk0PetlX6c9uXaUx1KU3AQ1pIJgjjXS6X1Ymlhre+BeSQAjgyQooPCKBAKVp8tkQ42PaZ+3iclSw39pFgdsoKIZXJefS1r5pA9qO7cDD6H9IQA7OFlGEHFnkeTJOFVpoRoZxxhTMEIs4731/UUmgm4GCuA/uRQ6TaVQqM1MYvuchDy0PrihoDfwBTynQvr02KQHSXK2Kx2qquUbCppYH28G55plOlqdGPx9O4wyQOPDdH0iTjtUfgHfwku3FcgzOQuCsR7XCIxzLn+HLj2ISXBvFnX3boAMkV0amRG90F9j0gafSc5+Qkq34iKrF2AjAJKCmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kdNVcejQfZB+AZBDRPMTsJ3cfJ4I6ZCbLQS6KxETfI=;
 b=PblkPW4KIU8RcuN0M83fTgZPf3txXh/AE5xWPcSxLhvl+4XrXM1+9E0RH1IM0pfdR5py8mRb4Gfl72o1SARRZc0+IgOXd/GUFZJrWPSCYAxEH7KI7Z2YJ0ZxPny8m34LrZNDR0oxNO9OeJLFCpX0arfpf1jFzw5CKXrEO3HiM9+tbpeffbhYT5Eo7TDK0DMy4S9jNTUWVZ95ClD2UgxPLW2SbF9iQ2XN5WOji0hK8ceDfM/p7DhK9i51qOTITE6ex8aXCWx6ND5nnJBn15DUB4KUg2dCY8ql9kN0gLE5VXAUng4oo/ZilmGWhpR1zeknCWr8Q66nSpXGYnliDj8TDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kdNVcejQfZB+AZBDRPMTsJ3cfJ4I6ZCbLQS6KxETfI=;
 b=YwOJvfkLDTpDxWHY9OO5PrmrgdzdW9NqzasGt5vr7pmKZZeK+41T/jHnU7NDLjyjJbYMru3LpY6eqY6YRGD93G1G+gTpj4eOkaREvIgHpg8cj0DFjQsYl3hqL0upXXr6JSNWiawTMpZaxJb115BT/2AQ2nrqtR4USFdp6rXzf20=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BY5PR18MB3090.namprd18.prod.outlook.com (2603:10b6:a03:1ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 13:56:20 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::5d5a:a759:2bad:f8fe]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::5d5a:a759:2bad:f8fe%4]) with mapi id 15.20.3216.028; Mon, 27 Jul 2020
 13:56:20 +0000
Date:   Mon, 27 Jul 2020 15:56:10 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
CC:     Hulk Robot <hulkci@huawei.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
Subject: Re: [PATCH -next] EDAC, thunderx: Make symbol 'lmc_dfs_ents' static
Message-ID: <20200727135610.cjqugnropvtqrxn7@rric.localdomain>
References: <20200714142308.46612-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714142308.46612-1-weiyongjun1@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0901CA0063.eurprd09.prod.outlook.com
 (2603:10a6:3:45::31) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0901CA0063.eurprd09.prod.outlook.com (2603:10a6:3:45::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 13:56:18 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee7e05e2-0232-4234-ed57-08d83234d6cb
X-MS-TrafficTypeDiagnostic: BY5PR18MB3090:
X-Microsoft-Antispam-PRVS: <BY5PR18MB3090BACEC6AEC70E96E873EDD9720@BY5PR18MB3090.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjZqScnO4LyTQFKN9mvdQAJZTV27JewWgUCoNf5akowI2WcXzsf3f0pdVnc5xdjYXehSqkdVcrdrj1TZiEa+ETxoxg2gtZsRa2BkbzDgnJ3Ca3nZiXYOMYzq/yCZS8kv+06MWRJ31Iov2aXuv7o5WphNSMNJPEXHltyfXgNggnqNzR0jK5cpNxRLcyo948QbAOp2etT6LP6WZOXaIJgdC2Z71zgBoOCS34XlTHxTPv3O573l4Lg64hxpztQTu7dWTmkbhaHbu5SvEdTBviPzpMfskcbhKfUkhKCgxli7Cs1ZPNw0qoh5QFdKt3K///T7OImSINx2oTgpLd6DdZDsuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(366004)(39850400004)(396003)(53546011)(83380400001)(7696005)(52116002)(6506007)(86362001)(66476007)(66556008)(66946007)(5660300002)(4326008)(186003)(1076003)(316002)(54906003)(6666004)(55016002)(9686003)(478600001)(2906002)(6916009)(26005)(956004)(8936002)(8676002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bfiZnCPQ1hyVf2oVzDBQ5XuBleCk8JQZSC640+B/3OeHfersbvKqZCvp2TB8LfIk0TyqyXCkHcpOnHf0cmtd4elfAZ+uWJHgRZLUyPyi9yLiLtg9NCV+V0P/wA5H5sW8kD91CaTHrvYVM/sF+F+ifSHCAxfN7gfiXoTpl3kwIZdP9EMZ15TasQalXkXAW4bEB2Drr2U8SiLYyor6K1ULAo2Qk2DOYzCHIrpmTtFdjagJuUmhFXP1QvL0jh8Uj5fnQwGYznfd5ukAb7mu1uPy3bb0oFq81uwLu2f6bbgDoZimuvnfm85k1jFNKuJRaly3jxBAIdBsfvlgFX+iOYmwm7W86kR7JujpvC4ARGjivPY3Ww/Pyw26ZHqSliGRhNDc4/0oWR2xX8I8n7aaGIFoAMaLLWAxK1TiRWdnEgB4xp4RIR0NV5sFwxKZNcZmQ7iQUZvt/IkUT3Q3iemoukHx39Ux0akfT8TTt/qGe3gXMMo=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7e05e2-0232-4234-ed57-08d83234d6cb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB2661.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 13:56:20.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Llyt515RxJwbIjYnX9zMeOR20uk7YHIspTt4n1yqHrLSbuWIzVtzFKngb9Di1kdYrVOOiNr45KY95D+erNZmPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3090
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_08:2020-07-27,2020-07-27 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 14.07.20 22:23:08, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/edac/thunderx_edac.c:457:22: warning:
>  symbol 'lmc_dfs_ents' was not declared. Should it be static?
> 
> Symbol 'lmc_dfs_ents' is not used outside of thunderx_edac.c, so
> marks it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Robert Richter <rrichter@marvell.com>

> ---
>  drivers/edac/thunderx_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
> index 4af9744cc6d0..0eb5eb97fd74 100644
> --- a/drivers/edac/thunderx_edac.c
> +++ b/drivers/edac/thunderx_edac.c
> @@ -454,7 +454,7 @@ DEBUGFS_STRUCT(inject_int, 0200, thunderx_lmc_inject_int_write, NULL);
>  DEBUGFS_STRUCT(inject_ecc, 0200, thunderx_lmc_inject_ecc_write, NULL);
>  DEBUGFS_STRUCT(int_w1c, 0400, NULL, thunderx_lmc_int_read);
>  
> -struct debugfs_entry *lmc_dfs_ents[] = {
> +static struct debugfs_entry *lmc_dfs_ents[] = {
>  	&debugfs_mask0,
>  	&debugfs_mask2,
>  	&debugfs_parity_test,
> 
