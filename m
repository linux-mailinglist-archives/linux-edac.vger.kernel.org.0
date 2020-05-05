Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625211C4F9E
	for <lists+linux-edac@lfdr.de>; Tue,  5 May 2020 09:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgEEHuz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 May 2020 03:50:55 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:55064 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727784AbgEEHuy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 May 2020 03:50:54 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0457emDC002878;
        Tue, 5 May 2020 00:50:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=KToQK0u5Zh5L7XwHVqKPrKBZbWQjeJQWQryQKCGH3mk=;
 b=Bh2vpSYBgYt1zkERtKTvRX9IZ2FLB8vLiiQkQ3WlMs35fFQiPE36+5vPAeDWSInom5M6
 tHeFMf0UuPoOTrexRn+kNEvmgmfgQ2nkeML0Btjw38KLZMJIkmL04J1NPjEYUy5KW2ET
 0scXCU8OCrScIkEKdCsiGXHfrw46ZFQonmmKXOxofQEETkDNsSFNhpwPZqL4ZP7zlpTo
 uCa7o4eYXQY3gopURB4WDRKBMJcqZDVuMrGmtdze/A2RV/9kB/v/X3B68WUKXZfxEIWV
 l0Ex5PQqzE3tc27I3jjhjaMUZLbZf+lmG39vAC0Ko8YC9dZ3mcNsbBgU26gl2wKJg3OA zw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 30srykqw19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 00:50:30 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 5 May
 2020 00:50:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 5 May 2020 00:50:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr+b/Bq2PKCoikabWMrO0jssJBIX9nAkDZ0KQC9gEcq/j3K2vJ7fII79Bvurz9LGAk4niMNLWQX09I3R7oNtj0NEgAnillPWBRn+fs78fJvx6AxbPzTtUN89Fx92lB/GV2u1Kal3V6O0+fv6A1EnUc6u1Qa1Ryv8m2RMgVQRCsYXFaa8pGBY2cvIISYePiInaPWiU/8HJr4h4/sC9q+P8nU5w6mi5fk5GJ3RkGz8inzRtiKMgoz8/MzbeEl5xF1X0dO+8nUSfXeBpRl5Jc+Zh9HGoMOYW0Du8vgj0lcLYqO8b02G4L/AlXkXAofXNDUDAabircH4/8ZCTLMlpP3Hkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KToQK0u5Zh5L7XwHVqKPrKBZbWQjeJQWQryQKCGH3mk=;
 b=DKJ8paeHx1gBlvDNB9107Kh3R0V+C1xJ/jYa1XZb3JSwce2c1cdAKwhmwJD2aI3e5X4sWdyYbIT+7dyGIU+16fcQvGuz6Rn5GSzlyydpArNg5kIFhLPvmwHFObKw9YaBTNZayYF6eOvfh9bunERybT8ykpnwWi8xLT2ofFFycCOh9DFE4gvFaNNHLMcqV0q0rd60aaSsbnDNXg3om/p/9DMA5gWracQPb3S2862xT+DHHfQpojh/7kb9yaV2qFYCzOMRgqtgqqjXWJ000Vx9ongzwrSWudU9NYJrJFt7TQjZLIyQ5AIWui3rmYqHAu+ptDzDaMeMy7Uvx1hGlYyGIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KToQK0u5Zh5L7XwHVqKPrKBZbWQjeJQWQryQKCGH3mk=;
 b=e1IO2cwm3AJmnMmR/2YIgRxVWpuncDTdXAzEuLNtNYGju6QR6+fL7wRQOErM84HXIwZFmrpEKchZJ+HX9zmN0c05nA1vySdMnhTOTrCOVnqlNeYOeusaBDCAifniGRNfZlWsX63SPJ4muvrz4yR2ILAA+3REPgf9pJTxUi2ACak=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2902.namprd18.prod.outlook.com (2603:10b6:a03:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Tue, 5 May
 2020 07:50:27 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 07:50:27 +0000
Date:   Tue, 5 May 2020 09:50:17 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/10] EDAC/ghes: Remove unused members of struct
 ghes_edac_pvt, rename it to ghes_mci
Message-ID: <20200505075016.jrroszfnyjy4hsmd@rric.localdomain>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-4-rrichter@marvell.com>
 <20200423175517.GG26021@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423175517.GG26021@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0269.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::21) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0269.eurprd05.prod.outlook.com (2603:10a6:3:fc::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Tue, 5 May 2020 07:50:25 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d73d18fb-ab57-45b6-514c-08d7f0c8f9bf
X-MS-TrafficTypeDiagnostic: BYAPR18MB2902:
X-Microsoft-Antispam-PRVS: <BYAPR18MB2902FE4425790B2B7C695EFED9A70@BYAPR18MB2902.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pS0tQdX/aRIRUuEoJldhCXKNfVcygnJR9ZnBqGuNSqAD9i4PZhx8MIk36FMzGK7PAxGU1pcrkEimS3HSNfnxnBi4oBZ/ARpBD9c4o0Ds+s4oSLKWk6Hc2Ig8na3Jk3qtqb2wshJk4uGWGn0ZvtqABL+orUEwAsYxto+LjDp8Y4iQ5o39+LQxRml0Y27d/4JfagTdRjF3Bc32NgftQ8JOepELQHkYEaazrz+VMUwhxGFTeODAgOKJLARXRlk7tTGWbggtFSaxltwZuI8sIKN1WvIEzWeOIFzuT8q/jSHLp3PgzDL9C0cmuoXJPnAfLjEuBLMrmW6Fx9Y7AA3IuZTsw/h/QQCMucU5/y2jkBAC+Nidj3iwEyc1Ib9F4hERjqlAGIH7BRrvWRrlX6m6Lysy5Y+7ReQq6b4JCg9i6VyBgvW8ySJil44iwU5Vf9PSGYAcL6U9TnWc37jVsbO+bhUBPjVVnw1UXtXwDfVnpzn+FRVX8mYAm+UD0bIY3ecLq3/wgwPKQTsXcGxNfRDviA7u5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(33430700001)(6916009)(26005)(5660300002)(33440700001)(7696005)(6506007)(52116002)(4326008)(4744005)(54906003)(53546011)(55016002)(9686003)(316002)(478600001)(86362001)(956004)(186003)(16526019)(8936002)(6666004)(66946007)(66476007)(66556008)(1076003)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 76a8mTmIm7+VHOkPADgzFR0jX3okkZt1pDzep+kEfKhBmAecDuOyyGJVqedSlOxgdhWZNWjz3dQCX3fV4XqevGpewhOHGwXYhTjggD4goUEFhcAbcpjOGTCayvkylq9NycO9bnKLSaCTFaaAgjTWBdm2qxsWoCLOaXy2+xss3tBcq4OrsM7etGw+70hKqRRlepBvZQ71HDIxHv8fVqQEvVHdBtfyJASAGYU56qlNbb3/QRZ4nFsiaAd8tZfIxRQSJjzVk3164Ik09675YfpbsOqQ60IhNfdeYUit8EAKQSX9yIFpZ4LpLb65gdgZbmH7U1VELYy4Yf5O0MHB6KCxAbTSexxHSc7W1qb7nYozMKZi+bs98/inb4Fl6Lpue35UpGVPB0TQjJuF31ygJyL3z404txvtGcqPv9VasxMsYP2g67twE69upOU9hG9B4wKQ8qh4zY8tFC5UMz1ciWDYtDGNEyeAk2zQMb9tMgHEWShU/VTsbEGgSDNgHAAncu35wHMdsVBZ3xd5fmcudumdqgDdTp9lIzJTvJudjUoQq8V2Jxe0eWqTV7f/b8s4b2fkn0VLzVvkSrdTe6NZEEH5rrpIbT1kKh14rXKniH0Mkaf6/S5IL+1v855CJWZ21W9qRmuF3OKO/UBNJO2KeH3XWfoQG9f79TMbUEJlS/jDbtZsNVdupJSjtu1trkg6vFSGI1QiGJ/wXtJAnL78oJzzhhL+eY2SFX0z1xz7Uh392kCGWXyi0sK1UN2VwHYHz6wHp5n+O0XiELWxxcWZZcxAv5VINZT2WkUFOUsAJgNgULY=
X-MS-Exchange-CrossTenant-Network-Message-Id: d73d18fb-ab57-45b6-514c-08d7f0c8f9bf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 07:50:27.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiEHDWMNK5KGJlC0bEt5ZM7G7aKEAGY77znkS324fQ6OVfeDkJPrUQqsnB6DrTzS4R0M1473MRg6Uu+xDoi9GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2902
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_04:2020-05-04,2020-05-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 23.04.20 19:55:17, Borislav Petkov wrote:
> On Wed, Apr 22, 2020 at 01:58:07PM +0200, Robert Richter wrote:

> > diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> > index cb3dab56a875..39efce0df881 100644
> > --- a/drivers/edac/ghes_edac.c
> > +++ b/drivers/edac/ghes_edac.c
> > @@ -15,9 +15,7 @@
> >  #include "edac_module.h"
> >  #include <ras/ras_event.h>
> >  
> > -struct ghes_edac_pvt {
> > -	struct list_head list;
> > -	struct ghes *ghes;
> > +struct ghes_mci {
> 
> No, that should be "ghes_pvt" because it *is* ghes_edac's private
> structure and there's also an mci pointer in it.

The ghes driver will use private data for both structs, mci and
dimm_info. Thus I named it ghes_mci and ghes_dimm (see next patch) as
they are counterparts. I could name it "ghes_pvt", but the meaning
would be less obvious. Same for your suggestion in the next patch,
struct dimm is too general and could cause namespace conflicts with
other code (think of cscope etc.).

-Robert
