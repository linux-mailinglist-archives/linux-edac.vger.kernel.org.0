Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82AAB1A1C5C
	for <lists+linux-edac@lfdr.de>; Wed,  8 Apr 2020 09:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDHHKw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Apr 2020 03:10:52 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:54932 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbgDHHKw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 8 Apr 2020 03:10:52 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0387AD3B024248;
        Wed, 8 Apr 2020 00:10:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=pfpt0818;
 bh=KfsM0BBZQClf4bXztfgbhhU3knbCr32uIMfNfu7re7E=;
 b=SCD1qBoE51vU+bJrgDP2tAPoxAPm75mO4qK4sPpuR/eI7hEtqoOyX/jAwPAlR4c0Gzxd
 FQwDpCsmx4a7TLgsMV1wf1fg1cv8xFp97+i781ROxqtGeoSN8+vFqsLDp0uePQ3dyXWJ
 A+XhsgKYESe7vbVcADssdMjEhwLe8oWU17Vzyz0tH002db7WSUtzWqF5XQdMd5xq8pkI
 JNAoq1tBTCnNhQEi4E0s8fJdbFHf3shDirsxhox/id3/Yn5M12Jgpc3TF+GwvT/MXGnl
 I/4Do+Necf26Jy1SRaEp7S+bq8vvs8xSN7VRVpfZE89QKg5Vs+P+6fgu6ImDrETLqQuO mw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 3091me22hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 Apr 2020 00:10:36 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 8 Apr
 2020 00:10:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Apr 2020 00:10:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCqHj0YGNuFPyh78tsbAT4kJrQllHNYioKUQlDvn5RpudSGVPOgC6OX4spCza4O9MHsSYHFdcCGpD93/bbLY08dQZaN4gQYXydQvvLGd/gPCoNDnacPyZHRyxOPVteBMjHXVL/dKzuJO246gge2x4Sqz4bFWw/co5xTFOrbGW0DWJL8xEuuD/tlc6S5sGYZ9fW/ju4wnN4DhRy7ZMY10doRAmbvcFEL2QqKbsozMpBJRk01QtPJQ+ls92jqYBQi5qvC3Ty58mBMFVS+yhVDERca4Lfz4kSa1KYn2HzI9RB6lGwoZQe4wV114EtE8g628cvl6pp5WDe7vtmBPVBfx1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfsM0BBZQClf4bXztfgbhhU3knbCr32uIMfNfu7re7E=;
 b=TlAi/ucGoyKj4uScbbBSJcgi1fz52mJXdw4yuA11T4RAjNjI/Cucnc0Pj3WhwFR5irThytknUtXyAKNESBA44D/SKDwdC2c+OEhXAC+lYjTDHjehBCIMjdzYLyGip5EQ3rqfHZO9glL/Z18xCaScOXMf3Y/GSTtnZLu+dhESQUuj72CM46h+zy/gpEBwD8L6mkfs+gEearAY6qDB1OcwM4Ro8v1yTO/G/wgpPTUtokQQJZIp0SkJgxfhOOeoQwMyBczR6sv+OEvO5X7n/XC9SMNxmnjqhEEANErjfZYKtqasQ6BzPlOLmqNOosE9qz91vNFX0DEhd9AyU3NEK5Fo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfsM0BBZQClf4bXztfgbhhU3knbCr32uIMfNfu7re7E=;
 b=ocpD5NZLwWJHxNXkL9UBonjaGTAoKM2PfUsUdE3RlBAFF7iXbbcpC3Z33q/1CP4+B/AouF79FB2khE5WS8AbYBmS1CWQv4MbwubWZXZHyDv12Iudg8m/KkB2Y9TrgqHNgCx9vXt1ZUxuFurG0/4D3K5lJb432Uwk5fMa5DRcNkY=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYASPR01MB0026.namprd18.prod.outlook.com (2603:10b6:a03:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 07:10:33 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953%3]) with mapi id 15.20.2878.022; Wed, 8 Apr 2020
 07:10:32 +0000
Date:   Wed, 8 Apr 2020 09:10:23 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     "tangbin@cmss.chinamobile.com" <tangbin@cmss.chinamobile.com>
CC:     "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/altera:Use platform_get_irq_optional()
Message-ID: <20200408071022.ft6aamptrxlaz23f@rric.localdomain>
References: <20200402112740.15580-1-tangbin@cmss.chinamobile.com>
 <20200402123001.obgzqmlure4cfvh7@rric.localdomain>
 <202004022106312118022@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202004022106312118022@cmss.chinamobile.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0501CA0004.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::14) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0501CA0004.eurprd05.prod.outlook.com (2603:10a6:3:1a::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Wed, 8 Apr 2020 07:10:30 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adeb3405-5523-41b3-5dcf-08d7db8bed28
X-MS-TrafficTypeDiagnostic: BYASPR01MB0026:
X-Microsoft-Antispam-PRVS: <BYASPR01MB00263710993ADB014566A672D9C00@BYASPR01MB0026.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(16526019)(66556008)(186003)(66946007)(5660300002)(66476007)(26005)(1076003)(81166007)(54906003)(6666004)(53546011)(8936002)(6916009)(316002)(81156014)(7696005)(8676002)(55016002)(966005)(9686003)(4326008)(6506007)(86362001)(2906002)(52116002)(478600001)(956004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qI9m+/FpARkscbFR2koPf8tGNJIU4/ssXStGph4BIcCBDm5snvaXGoxp2rIhxAEtMKEl17mRAyXmHu8vehz8Tu8XBh8tvWA727+AaJaY6CpUuFyrJQ2ZlNQ/b01UEQZgpRHLAhevyeLW1I2P+dW6e9LgyJjtHQtnfKMLPbRgQWkEGlMTGlVOJpaFFd++amt5+Sm7R1Ti2wF+umYUhM5ST5rZUgTmcFoRIj6b6ZDvU+pDQsRz2wYmoTljlL9kQspwnnnLwSZLWEPA0pa4YaUyzG6W99XPcEXxqCCdmg9Mbbn/8IYopaGdIUUYcLUnovmLGHMd3xPD6imJTM+kf5xoC69GHvvq7FnMftcvyHoiQFdEMibxZhkwN7bMa2qijD4r8+bWeoxs/tgMaLpc41mwRwmphXZqgxv0Ptnn9zYZieHZKG/cX8jgsw6YJfTNTiF6Pm8HBULP40/G5/Ej5A7v/+6t9LUsGTmIIWFEo2dmGqEMT1lBBEoVUPPq8/z/Y83ulWv9WmyuL2c046MyZidRhg==
X-MS-Exchange-AntiSpam-MessageData: 7CD3MSEo9lqEFgT+/0IDJPM/IyoxGdCTbIDzUK3SvwSNus7wRryEFGgtIDKErPYWkppDcg7/1ypassXpA0kcj/etD2/zZKRGoNqgGl5dcjC0n8wWM16pEfbzVUsxmYiwuo4WVtPxpL4eMDgJcjhHyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: adeb3405-5523-41b3-5dcf-08d7db8bed28
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 07:10:32.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qeI48xJMEHL4B9I2iOgjDhx1ObbckQ3TiOEosULFrGUNk/Y7iHlz3IBnxuAr/yUiFPQh+CK7XZiZb3gz2HnLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB0026
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 02.04.20 21:06:32, tangbin@cmss.chinamobile.com wrote:
>         Thank you for you replay,what I want to say is：We don't need dev_err()
> message because when something goes wrong, platform_get_irq() has print an
> error message itself, so we could remove duplicate dev_err() here , or use 
> platform_get_irq_optional() instead. Thank you very much!

Please, do not top-post. See Boris' link in his footer:

 https://people.kernel.org/tglx/notes-about-netiquette

See, now your answer is out of context.

What is wrong having 2 error messages? You want to know of the error
as early as possible and see the causal chain of the error. Hiding it
makes an analysis harder. Errors should happen rarely, so why save a
line in dmesg here? In your case, the irq is not optional, it is
required. So something is wrong if it fails.

Thanks,

-Robert

> 
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> tangbin@cmss.chinamobile.com
> 
>      
>     From: Robert Richter
>     Date: 2020-04-02 20:30
>     To: Tang Bin
>     CC: thor.thayer@linux.intel.com; bp@alien8.de; mchehab@kernel.org;
>     tony.luck@intel.com; james.morse@arm.com; linux-edac@vger.kernel.org;
>     linux-kernel@vger.kernel.org
>     Subject: Re: [PATCH] EDAC/altera:Use platform_get_irq_optional()
>     On 02.04.20 19:27:40, Tang Bin wrote:
>     > In order to simply code,because platform_get_irq() already has
>     > dev_err() message.
>      
>     I don't see a difference other than hiding a -EPROBE_DEFER error
>     message. If that is your intention, please update subject and
>     description accordingly.
>      
>     Thanks,
>      
>     -Robert
>      
>     >
>     > Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>     > ---
>     >  drivers/edac/altera_edac.c | 4 ++--
>     >  1 file changed, 2 insertions(+), 2 deletions(-)
>     >
>     > diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
>     > index e91cf1147..e12bad148 100644
>     > --- a/drivers/edac/altera_edac.c
>     > +++ b/drivers/edac/altera_edac.c
>     > @@ -2099,7 +2099,7 @@ static int altr_edac_a10_probe(struct
>     platform_device *pdev)
>     >  return -ENOMEM;
>     >  }
>     > 
>     > - edac->sb_irq = platform_get_irq(pdev, 0);
>     > + edac->sb_irq = platform_get_irq_optional(pdev, 0);
>     >  if (edac->sb_irq < 0) {
>     >  dev_err(&pdev->dev, "No SBERR IRQ resource\n");
>     >  return edac->sb_irq;
>     > @@ -2134,7 +2134,7 @@ static int altr_edac_a10_probe(struct
>     platform_device *pdev)
>     >  }
>     >  }
>     >  #else
>     > - edac->db_irq = platform_get_irq(pdev, 1);
>     > + edac->db_irq = platform_get_irq_optional(pdev, 1);
>     >  if (edac->db_irq < 0) {
>     >  dev_err(&pdev->dev, "No DBERR IRQ resource\n");
>     >  return edac->db_irq;
>     > --
>     > 2.20.1.windows.1
>     >
>     >
>     >
> 
