Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1F219C10D
	for <lists+linux-edac@lfdr.de>; Thu,  2 Apr 2020 14:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbgDBMaj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Apr 2020 08:30:39 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:64246 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387699AbgDBMaj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 2 Apr 2020 08:30:39 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032CQSws013368;
        Thu, 2 Apr 2020 05:30:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=sIj2I/oq7s90i91AUPFKv8/XHA3/u6H7T4NENAjESxU=;
 b=GxEMuBtjVYYckgmTaULmKK4zVUl2aZUBWdZ7aeGvjGPd6w+rSS4YMakWV+irrUAvoTca
 Y2c4IKJtZ8PH7xN8NMrW0uHqiwRHB2dxqDfGRizeH3DqtezzwkvOGDYM4AHf9byYgqLn
 qllhQuZIWTacDfHnLgUf2res0CMmt8dMD++o7zL2V6HCUwbGfmHcxYJEyQyqFCtwl6m0
 ZO6XRZEWTAYfg/WwmAyf28de3kjkHkiRktYw68Mo11l91hKWUspf3yxoXfVy4Smhyx0B
 MHPGNT3GM0GY+FGkJsnPkyhgzzJec7suYk2A2TnweomlIGamVLo8EcCTeRoGCSXF09vO Uw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 304855st1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 05:30:15 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Apr
 2020 05:30:14 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Apr
 2020 05:30:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 2 Apr 2020 05:30:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6/ULQCOrxalJUtbcxDSx0SPGNkqqX85IwKM3KRXngf/oeWHT2OY1qcgK5u7HgzYcpZ37OKFRSb/JFCagr52mBQ+VF8H3x+yV0eh+/Et/0QE5s2Q0SFgNcZFV6jnOmFMgjPrqpN3xWXiKaRX4yxTkJgisvMtCJxGm8X72ZqZhIR90xOtgyfrDecBaQOOcxggkvYO8I2chyDF2jDsFLDIah3tkZlqV0fkzHLePIFbjw7j6F/7Xbi+lfSOGB2RE1Iy1+ituttlMTX5OM5kXsDTI/3QEerE8qY5TYmVNC7G97DyM737lxrmF8fkyRJKUARGH0A0WO5oxLb6RawGIsgRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIj2I/oq7s90i91AUPFKv8/XHA3/u6H7T4NENAjESxU=;
 b=cfZfR1bYJVUxUEL3bPL9ashh3IJ1J6FFZ4EFZ2Etg3ra/iuVkMEDBqj1cbBiGa2FmI83UsDvXJY++jv7SjEHgtK1GYFN028z+V64FhwJLYNgfA/6zfk+zRSzw60rtSYoCUrowdcOc8Yo/N6LGxWGTva+hIShO6tZ6jAHi3tUizEnyDsWlboMGLIEAD2oneWXcXCChkfxWLLO/EEhJ5TrAY8lt6+1dKlbLlJw/5tn3BJjqvlshrOwLdT8tsfZM/2/lBAKsw04O+mDweT0FzmmQO5ZMeZU/ASkUWR4q9A6cmekIUjc4mWWiYRV7y7ZF+tbZ3rWa4sdV0NqFIj/8H84OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIj2I/oq7s90i91AUPFKv8/XHA3/u6H7T4NENAjESxU=;
 b=hbz39oJSFG3fMMCEMpg1krwLZCFNrg0i0Kz8L5JuLZGa2tj/HPJksc5f5BwglYZHVJVAjP8awgfBjaS7f1QI32lpgZ9uDxL+BOhJ5Tdc4yRek3TFYHD8z74MBxRII75qPzPdrTYEXECZe7M5F3Ig7eOdo5U10j7SwLSrLnARhBs=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2485.namprd18.prod.outlook.com (2603:10b6:a03:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 12:30:11 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953%3]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 12:30:11 +0000
Date:   Thu, 2 Apr 2020 14:30:02 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
CC:     <thor.thayer@linux.intel.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/altera:Use platform_get_irq_optional()
Message-ID: <20200402123001.obgzqmlure4cfvh7@rric.localdomain>
References: <20200402112740.15580-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402112740.15580-1-tangbin@cmss.chinamobile.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0192.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::16) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0192.eurprd05.prod.outlook.com (2603:10a6:3:f9::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 12:30:09 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 479888b1-33c6-4a02-5a5d-08d7d7019652
X-MS-TrafficTypeDiagnostic: BYAPR18MB2485:
X-Microsoft-Antispam-PRVS: <BYAPR18MB24857D685875FD4F8C23421CD9C60@BYAPR18MB2485.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(16526019)(81166006)(1076003)(86362001)(66946007)(66556008)(66476007)(6666004)(9686003)(478600001)(81156014)(55016002)(5660300002)(8676002)(316002)(2906002)(26005)(186003)(7696005)(956004)(52116002)(8936002)(6916009)(53546011)(6506007)(4326008);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o39WEXSMvx6BKat03knhyDw2TcrgMEAAjto5IQVOxyQXVqfBG/G8DS9MzgGa76NOzYve2sIiCHO1CLVGgqS18JUFzmQjLs9bDvr9tYGJjAWPGOr/wwOLNUtSs0lrdUfcnNz1lITwsypK75iKffLBV1jFpeFWehTjz0UjMWcPbgcY60764HdyJs/aHywyWujlCDEa6wVTK/EJHXmEyjGWAzBmUhvOIQIFRF6XQN5oHD4287Hb0YnTsAJmXm7yiMX8mTl5DayYednvjeWJ+EJdc8+k/D9Vwo47BvVEZXaBLU5ij3jVq8/VD4kX7O9cMWPC8U9M8vsDMlXbeBiqzHa8Xyea/d8FIz6Er3PcDZFQLu8V2HlLDe7V5eKO42PLtJv42vaFOuciCsxQFC6yy9t4bQkxV+hupuA51C9eMAYvO2PR5GklRnZG32GvBqYiqLkv
X-MS-Exchange-AntiSpam-MessageData: hzzIi2uRmeXLqwEk5Hxu1nzTzBk4hyfMWBRvQJD4Lj8TRaIpKuFROSPADwbcW+YPxtY12dS8Y9OrQAeUVihMXgsMkqtQW+e8v1SluM85Tysg0JmM0xyeCtap2u75y5CkGf0l/3WNCeJp/R1A6d8Klw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 479888b1-33c6-4a02-5a5d-08d7d7019652
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 12:30:11.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTvlZDf3vJKwN40CJq96DsI+S3uVN3am/MpXgY1PNtK9OPfJWuL+PTNteO/IMWth2Evd7BTw96S+aO6U9WWy/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2485
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_04:2020-03-31,2020-04-02 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 02.04.20 19:27:40, Tang Bin wrote:
> In order to simply code,because platform_get_irq() already has
> dev_err() message.

I don't see a difference other than hiding a -EPROBE_DEFER error
message. If that is your intention, please update subject and
description accordingly.

Thanks,

-Robert

> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/edac/altera_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index e91cf1147..e12bad148 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -2099,7 +2099,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	edac->sb_irq = platform_get_irq(pdev, 0);
> +	edac->sb_irq = platform_get_irq_optional(pdev, 0);
>  	if (edac->sb_irq < 0) {
>  		dev_err(&pdev->dev, "No SBERR IRQ resource\n");
>  		return edac->sb_irq;
> @@ -2134,7 +2134,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>  		}
>  	}
>  #else
> -	edac->db_irq = platform_get_irq(pdev, 1);
> +	edac->db_irq = platform_get_irq_optional(pdev, 1);
>  	if (edac->db_irq < 0) {
>  		dev_err(&pdev->dev, "No DBERR IRQ resource\n");
>  		return edac->db_irq;
> -- 
> 2.20.1.windows.1
> 
> 
> 
