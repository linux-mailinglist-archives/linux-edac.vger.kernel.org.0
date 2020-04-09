Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EECB1A3192
	for <lists+linux-edac@lfdr.de>; Thu,  9 Apr 2020 11:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgDIJKx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Apr 2020 05:10:53 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49926 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgDIJKw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 9 Apr 2020 05:10:52 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0399AUck010249;
        Thu, 9 Apr 2020 02:10:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=pfpt0818;
 bh=VYMWXZdDnpx2fNUap5BCtn+JUWTkSKaf+5QedQQqng0=;
 b=YiyekxgMG9DQHYNYPc+JMdk9qTuCYtjAVLHAj2FP8tqy8mTa4uuCSI2GYEAuyD2SnuqW
 4gNtOL4i0cpQz6PaxlPLREcYzRGArKn+yFRBY5qPMH5BUSye7f8GW47eOf8dLEs9ln/+
 sJ+h1hfevFTeT7CtQrzA8fjhzkgnBsyGgACkRizdFIVdliNScw5aX4Kvh4bgFT4uo+A5
 UPohqsNR1opsPBue8omsh+TKIAstyaupYDqvrZyw117zasxBX9uBIWm8VGFOIlmR3Zhz
 bo+xxlRiQ9zFVmI2IINySeN++YkDjecOJFu2hq/WbG4zmt4BYZM/PCQRBVmxegvdsPkI Pg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 3091me7jpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 09 Apr 2020 02:10:30 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 9 Apr
 2020 02:10:28 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 9 Apr
 2020 02:10:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 9 Apr 2020 02:10:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfyPjtUHJ03Hms73eV3HrrKmWZjM2ZBlNn9plHZE3s+oUFjyqGmjGsGiiKKv8UvK85uiTVJmyJkO1Ohk8N2Bw4PzvDRsJ2Asezy1UL4pTjiJ24pMFj3B+LpKXeQpSbtgWNHi9TBaIIfYzLPN3rDwZsk/aQDPNxAQ0sszWo3sENt6wNubthWJDoj9BlK1RRgz+jNAQ83yBzzg323e9ZsC7+IS5kocw0YVikUvwWEcC5nKmZfxJ+t5/bCO/CG2MKwmEVyls7iA97jvcn0oWNYDejg5Rz9DFIYJbbDSJHS7S8ZLnYiaMsN0gcH/DW8gowGqzBeHvGltw3uLhM9rpt4kFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYMWXZdDnpx2fNUap5BCtn+JUWTkSKaf+5QedQQqng0=;
 b=kP5lcajm984zi6OkWsaapvnOQ/YHu1TJOtVSpUxnIOuw3LNQ5/k4KFz0gbDLMBTEry4FYbFKEbzWYT5HBN9wCUGIDpxoLjGBXJEUlGoi1ZB/cJw0eG8KMTlBmKjPj4tHYYhLVipQMLInJb++aYApwMXwgYSr06yuXPwpj+v72XEACp4Jsha9fTNIKY+wNjOJyI/dzDlSATbnCo1X6FSONOd2fSiXm+dh5CYQvB1fPOC3SyZYfGHpjE2IMK286kGZbgblMTdf+W5L5tOH7S+CkynMcFlR4IKQ3B41O6QEe4NTwUCwpjPrF7ocfvUSC8ZgIvuoZZOujiffAGqh62Cddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYMWXZdDnpx2fNUap5BCtn+JUWTkSKaf+5QedQQqng0=;
 b=SJGbUuHR6KZbI2HEuOXb3L83iUf48x0/5udD+7Y/5HstKJ4digCL4sCg74KW/25O1mTecV7Zyrcun9t9DXOOZ/ZWEjXlmPOfTvOFOFDX3tM9sV3Sgu70G+XuGVJ+aSJ0Jk6NoOf+0wpZbDhXofRBIqvY6P4vtwEhLx9BSjEcHGA=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2375.namprd18.prod.outlook.com (2603:10b6:a03:12d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Thu, 9 Apr
 2020 09:10:26 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953%3]) with mapi id 15.20.2878.023; Thu, 9 Apr 2020
 09:10:26 +0000
Date:   Thu, 9 Apr 2020 11:10:16 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Jason Yan <yanaijie@huawei.com>
CC:     <khuong@os.amperecomputing.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, xgene: remove set but not used 'address'
Message-ID: <20200409091016.d3uohmt2o3zwhmro@rric.localdomain>
References: <20200409085237.46642-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409085237.46642-1-yanaijie@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0901CA0049.eurprd09.prod.outlook.com
 (2603:10a6:3:45::17) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0901CA0049.eurprd09.prod.outlook.com (2603:10a6:3:45::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16 via Frontend Transport; Thu, 9 Apr 2020 09:10:24 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2567d6ec-e130-4133-666b-08d7dc65d768
X-MS-TrafficTypeDiagnostic: BYAPR18MB2375:
X-Microsoft-Antispam-PRVS: <BYAPR18MB237583794D6DD78F3ED66F35D9C10@BYAPR18MB2375.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(136003)(346002)(39850400004)(366004)(396003)(6506007)(9686003)(66476007)(81156014)(478600001)(186003)(55016002)(86362001)(6666004)(8936002)(8676002)(1076003)(53546011)(7696005)(66946007)(5660300002)(66556008)(52116002)(316002)(81166007)(956004)(16526019)(2906002)(6916009)(4326008)(26005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9P0lEIk2EoIf+kG5T6PDrUBlo5097Paf7Wg0dakt0qQqZOOiE6u0B8QWuA3muLVTVx8/XWqJo6r3S782MvXk7RgtnkAxaDxKyxxiCbDs/EftRKiwNfzVM+fS+rK7Fqw9p0Kn0cpOI95r4QH/mkTl7tb1esczau0nh73VZlFtcdncGzIGilvhr0tGI3sWHxTL+i/jYes2enUVYwoCAwwym5K4t7eVBzR7MdvoxFugm+UH3tjsbRGFsjKvEozaEprp0ZYvnSY3ZH+Y917F8kobOoMRe5H5NUqW/rlkm0IQUPBjciKU8Qww/hNTkwNxvuYW2gBo0sqUkl8tuT1XARRHNeHUnRIACxQtGlH5ex95RwKa6eouv1gbK1FpoRb8T6xpwpLWdZGnrmJWF5fH57wzdcC9k6jZCqGp+EHtNtF5jEyM9RH2LsguMso0Oe76gYiW
X-MS-Exchange-AntiSpam-MessageData: lEJcO5YyshLHHC/ltM7u45QqOpXbLM29npVIYcxn0S3aMFoS5FIbv6wwpjx4ftl4K/4f2Ypy0gd/hFqGJ6QmEnsVWRusqhdlluurtxM9qVrcbQBsJPXOlJHM+/pkb0+oS+vBnj+jKk74cm7UH6c+TQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2567d6ec-e130-4133-666b-08d7dc65d768
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 09:10:26.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0m6jfJSFVCAVedFmnUquvQUn/obektAPVD2ZrP/plF/RNNoGFqxl+iRVf2km5GcXSjzFWqUmzbruagwwUXOKfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2375
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-09_03:2020-04-07,2020-04-09 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 09.04.20 16:52:37, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/edac/xgene_edac.c:1486:7: warning: variable ‘address’ set but
> not used [-Wunused-but-set-variable]
>    u32 address;
>        ^~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/edac/xgene_edac.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
> index e4a1032ba0b5..e5e0fbdeca29 100644
> --- a/drivers/edac/xgene_edac.c
> +++ b/drivers/edac/xgene_edac.c
> @@ -1483,13 +1483,11 @@ static void xgene_edac_rb_report(struct edac_device_ctl_info *edac_dev)
>  		return;
>  	if (reg & STICKYERR_MASK) {
>  		bool write;
> -		u32 address;
>  
>  		dev_err(edac_dev->dev, "IOB bus access error(s)\n");
>  		if (regmap_read(ctx->edac->rb_map, RBEIR, &reg))
>  			return;
>  		write = reg & WRITE_ACCESS_MASK ? 1 : 0;
> -		address = RBERRADDR_RD(reg);

Please also remove that unused macro.

Thanks,

-Robert

>  		if (reg & AGENT_OFFLINE_ERR_MASK)
>  			dev_err(edac_dev->dev,
>  				"IOB bus %s access to offline agent error\n",
> -- 
> 2.17.2
> 
