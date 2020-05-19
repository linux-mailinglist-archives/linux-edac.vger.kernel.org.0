Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0391D9363
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 11:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgESJfB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 05:35:01 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:41760 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgESJfB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 05:35:01 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04J9YUE5028245;
        Tue, 19 May 2020 02:34:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=gCT13dFUxe1rYellNUUweLYZr/Iw3sYjxxaPH5qM/g8=;
 b=FC8UnTqoYRwJk4UJJ/vWWBEaRItFc0w0Gy5i3HyWEyjOw/Zw/r0ECwrb9H5MVCDjLlts
 027e1vcQl//NY7iVsB67aqMywUybxncpaPzWmYX2uxM3Fpzup0mR9qJM8jNuDhLD6xqB
 QQVyUl2fCzF8VVthDNkguNWGVNyj1wZ0OquCQaK3Ev2ckxYdtz1/HTlEditBeGXy3wXV
 cXV5RGLy3OYX6kn71SvxC9NwVSdCvt3SCDD4XzU89z49YGm0y7uL01A+ddj0plrAupvJ
 peCFMOZXcCXcgyFS24kzrIUfQMXiufn4aaZpJ2VHFwo5xR1C2WNflxNVt6IiM2qHcN6J sQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 312fpp2r1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 02:34:46 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 02:34:44 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 02:34:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 02:34:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSLB7XgNpjxo231KI19TK5Qt3SGDttIKgYsioQrVH3R/1g4RUbmt3SkC18ZKissKS9iSAMr3QD7HYATpRaDmrfmJtxJX0o1yDYRNSOO3z66CGpEUuoOGqrZPi33zxcKSFfKjQ07B9T2cbOThQ3an95oVtXB2sxhBKbtagqCxuLtAR8wvAM5vFn2U+3i1Lb8/aIdF72hS6JIrX6gS2G+LQ937HwXECC4SFJv9uKOHLQRczmeYpHjk6CPbmlnxEVsRiVucxMcdSu+UU+aHiAOX4iE5iBWnw38+XmKa6p/elFDzsoTSEGuwet5AGJLSz4rsUyWpNwNVPuN+B1ojfI1SFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCT13dFUxe1rYellNUUweLYZr/Iw3sYjxxaPH5qM/g8=;
 b=QpEfmvB/VQmswprKD6+aO+t6vzisT7p8cwgf8BU03DMYT9taIUmmVaeLhoBPTj+HxAxWsm8HcSkjOAxqYVJKt+CTmLiq/xQe+xf52+U59ZhHoVbWpOmZ1ZtDOliwF2a966CX2nTEZZKP+CGwPAgk2CynYB2GKblSVokx4fOZf2JxMxn+BsK5fcP/4/BeUnD0sJo5jjVOx/DOfdsgP+oFOoaIPFylvFZ+6BWVd7InoJmJimacxG4QY5cg8B/8mpgfGvVxJh7/CNWCFL/b4jLAtUqvqGhgC7pophYHtZPBRLWaHlgvcI97cdku6tg3v2zbOflmw/FIZoCzKkV0O4p0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCT13dFUxe1rYellNUUweLYZr/Iw3sYjxxaPH5qM/g8=;
 b=KpPl4YPRK84hHvIPjOceS9avg3Ojt6xUgPvTdgkYvdO7ZsHZGB4SSSPqBqvT+Eo84jGsfPBRWFAbwJ1hs6FSDjdOX/Blh0Dl/JvN3UEDPc/7rQtlMc9eV5/sgy4xdnqvl+DoDz6TZJl13vGinVKcw9v4jV7pwa7BodBO5GYMEKw=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2998.namprd18.prod.outlook.com (2603:10b6:a03:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 09:34:42 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.020; Tue, 19 May 2020
 09:34:42 +0000
Date:   Tue, 19 May 2020 11:34:33 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/10] EDAC/ghes: Remove local variable rdr_mask in
 ghes_edac_dmidecode()
Message-ID: <20200519093433.kl72ejffhecne2zu@rric.localdomain>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-7-rrichter@marvell.com>
 <20200427070802.GA11036@zn.tnic>
 <20200427172408.GA13177@agluck-desk2.amr.corp.intel.com>
 <20200427173402.GH11036@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427173402.GH11036@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0202CA0032.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::18) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0202CA0032.eurprd02.prod.outlook.com (2603:10a6:3:e4::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Tue, 19 May 2020 09:34:40 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78b71b85-2c5d-40fc-f8ae-08d7fbd7dbf4
X-MS-TrafficTypeDiagnostic: BYAPR18MB2998:
X-Microsoft-Antispam-PRVS: <BYAPR18MB299894066978122061D97CF2D9B90@BYAPR18MB2998.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98pCAWinBw5sl8EsNugvF2tGZZmN2fwtQGWdHAwivBE7vGWkvKPC2NSZTkapoi/nqA5bXcnrBcWfccSpeU9nGZNBQJie8YH1M2QHsdDo37E09kZAWMxg/WFMaZycfN6Z0gHLsA4aB109nfuf+FsCQKmoLNbECvpvwoBlNQt5OIdMDrPKjqyXdKQ+hTO2LdiRJeFroDwtfnO4ClSqwXY4VZZNsZ/mKTmZfWUWHYLnrvCQGFLz49JgHY26u2TrIluuYeRrZNHAbDUjbbv1Na1ABMbkBkcBOdJ1SO5wR+nslU09EtvV5SeqPRlcs4SHdDBbTXXplUE3FSu5J0MLchHP7yXyaBvHVYh788+LmrkR+LoRi4G5qfw7sUTZ/L0i2GtMg968/6tcBdCy8++wfk7mC5xnW/K1k04tUfftRQz1rDvYcnBB40+Dlbcnx72VEz/I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(956004)(26005)(16526019)(5660300002)(8936002)(4744005)(54906003)(316002)(66946007)(86362001)(1076003)(66476007)(66556008)(186003)(478600001)(53546011)(6666004)(4326008)(6506007)(55016002)(8676002)(2906002)(6916009)(9686003)(52116002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3C2MjKm7Ao3gTXYpJXrllnRqjOkR+DqG6HQI4u9CdyEPNlsyW1Wg4vztXbq/lAj+ptfa+o8KUhWcFiB/O1Xt2QJ5w+UDHzNqOLiL2rhEFOE7ffQ7sZZ9+H+IXqbdqEC5JiiTmwfJDnzLeOM2ihGiQNjWKh/einCCCrilUTe9cjPIUMRwQ1yl4N1t//Io+nsHPb1WHtX2wodhCdTjdd8UsDmlnsY4+6i3AUTyZQJj7kfsLkeokt99ams0L4PClawP5NkLBJswhDzQcjdPLDE2igSHiQdjnqR35UuvjR7PVnc25Ome9CZoSNh2/s3BnNnlDc7kPyNyFUQXsc0c8+4ROqtnyAvmFLYaNFZuz6+OcSDUnsVvk4D9xBNf55tOJIjJeSgNmN0ZCxbIV75Jg0w5NlISflLM66H8yFJbpuAc5CtFccibAsDEuxcvJ/EzEM/G+VEsKhxigV1p0KXBnp9haGRz6N1KkZSH5h9ww2id2pw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b71b85-2c5d-40fc-f8ae-08d7fbd7dbf4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 09:34:42.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XC07fnFeAI+VW1ABJQXw5FJXtj/gV5vJDPEJxIQu82sg1wUzRiDF+c2hPEtsnsXJ20q3wS8QBFDepPZf7ebCjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2998
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_03:2020-05-19,2020-05-19 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 27.04.20 19:34:02, Borislav Petkov wrote:
> On Mon, Apr 27, 2020 at 10:24:08AM -0700, Luck, Tony wrote:
> > That isn't the same. The previous version checked that BOTH bits
> > 7 and 13 were set. Your version checks for either bit.
> 
> Whoops, I'm confused again. ;-\
> 
> > Looks like the original with the local variable was checking for both
> > bits set.
> 
> Yeah, let's leave it as it is. I prefer the rdr_mask thing.

I am dropping this patch from the series.

Thanks,

-Robert
