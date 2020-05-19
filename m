Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223341D93E2
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 11:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgESJ6d (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 05:58:33 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:9734 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgESJ6d (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 05:58:33 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04J9utvd028582;
        Tue, 19 May 2020 02:58:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=xEuXNmkaR8vYoI2kBUAUczw/cfhxPhmP7mLR00GVaSk=;
 b=mTAEJSov7hgXPSFZmOi5ePVMhP3Uc/uJlcn/M7PYTUsqwIT9ASRcSmvBVK6uNXrkY39K
 OSgXW7s7IxOWBMYODYxIvid0wazP9mcgD83N7+Is9NAbwJi9PAWll5iwJrMKKioPDqmc
 OoJY8ZMubl6ntkm5wBLvQPccr/WSjP96nZfKjL64idaOTx6gxO0VM/9Qmjr5P+0IVNp3
 ZQFr/JOHdd9r56IzWcZh1YwNteECw8yZZZbDn9nBLxZXQd7NDHQ9riNg0keuvQx9Ts/2
 Fq/6/Ho4tDX73oZnPelNnbK2dL/ga1zqxvI0eHWzbTwAtc0DY7tq8z8UqQYEU3q2LJlh 9g== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 312fpp2tjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 02:58:20 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 02:58:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 02:58:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XG1CfqMMh74oDuReBI+/i72usJE5//1uApp3Orr7aX3aspHGxs5/6fIgmnMqQu5SFF38qAEfg8LHvCCanq6v8litesCiTQZTolEDJhGcA7V1kkJG24EvDqXMQh9XFp4Le7IWRXrnNqArYWizCPgmzVCbgNeeRYWW23WM2QVKpMT1g2SIcLO46fMEzatmdsAIVVxutYJ6VtshAjXm9+4csEJqHcd5a31D3Dvi3LqhcbqV7Y4imDjhlQLXhNMYz6DCJso01fsTD4NyK2lxL1krx3D4VTgODBmVy0WN8Vo3FAbr0+lEsjgl7pHgVCTxvQdSkOYJWAGkiVyurR/GBdWfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEuXNmkaR8vYoI2kBUAUczw/cfhxPhmP7mLR00GVaSk=;
 b=YzQZJetCq+g2ZdFYu80SAGmNWHmZ3BijHnt3xATXFGDY7r1Qan/URrI28vtA5s88rxptu2gT5+ymkvxXrurSNSRIKMVuMsNmv8oscpFOK1rXrt8tLrsCXfVGFmAnlMC47OrANf7CaNY5CE8dTJvoDGE4vwQRMn9OEgVRRWHEYDwGFZFXvNBPUP3XWVKmEG/+ifa9ZWzwXT03uucqBwKo2BN+ZFm0u+zxyaXUlt7m7etYdUhXwC13dYShcAQcUVjKwskTkoLrpcRSaGNM8e6PwCJ5jbXhs3EFvODzrkV9iTaLKN9gDMdu3OQV4HPxoUqoEAurBny/BQhc1CSlVMHTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEuXNmkaR8vYoI2kBUAUczw/cfhxPhmP7mLR00GVaSk=;
 b=F1d/qQgQCBMB3JPKjTCTHGRHdCd1BbVzM+lNMHa6XDlFrPhOr2jV+gROwjdODcIJLqdirzFyKC3913rYxTne4BcNKSl5i5HYqOG2bqOTDGb+Yn+rSJXB5I59Rw4TEa4OZ7FwvSdqIWPbVjzhrTmiaT7padQ2olMQQeCt/s6Py+E=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2487.namprd18.prod.outlook.com (2603:10b6:a03:139::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Tue, 19 May
 2020 09:58:16 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.020; Tue, 19 May 2020
 09:58:15 +0000
Date:   Tue, 19 May 2020 11:57:59 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/10] EDAC/ghes: Carve out MC device handling into
 separate functions
Message-ID: <20200519095759.ghg7if6cijdlvjm3@rric.localdomain>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-9-rrichter@marvell.com>
 <20200427163856.GG11036@zn.tnic>
 <20200506084558.tcayd2fuzoe6rsfm@rric.localdomain>
 <20200511133203.GB25861@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511133203.GB25861@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0902CA0002.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::12) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0002.eurprd09.prod.outlook.com (2603:10a6:3:e5::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Tue, 19 May 2020 09:58:13 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b23bb9d6-a767-4bd0-17be-08d7fbdb263c
X-MS-TrafficTypeDiagnostic: BYAPR18MB2487:
X-Microsoft-Antispam-PRVS: <BYAPR18MB2487C78C403B16D5239FDB6DD9B90@BYAPR18MB2487.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWUxsUfQvRWsQdQ9pQfirgoac6MTUrw8fAcxpctmvyfw7tb1iNw+Arouj704iGCYqf+q6tIkD+1voeSLH5u4+zyslrYSynkcIGKg22p58VTFMtFFNObXsQwID4WNpcpOlsFpYoqTnazZeMcylxAumoQDSz9KNCWEmRefitqDXYCYTe4SPsbnBoyuL+YcXzU0q3XKJpvxmYkziosBOsTYER9WHdcuvNemknWDckoUQ58Gn/LIwdh+L9NMI7GXvsHnBR3hYsihrYpmPZpdQtaZwwdkMj3LvLz4CYrW1JHnZ4SWRSHmCB9Bgi+z0+4qib5gYMRiOyCRSS+bGsX4NrgfRC3vfzi3kCjvBt55E1EWKUX1qaovzuYpFkoLO97+ZpbNkV0a2i02Db15Ap00zvhC1RirYT98yQD8Z+PI8hmXbbQfWcEo5wXggGOGbOkYf51o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(66556008)(5660300002)(6916009)(478600001)(4744005)(86362001)(26005)(6666004)(54906003)(8676002)(66946007)(55016002)(66476007)(6506007)(16526019)(4326008)(53546011)(8936002)(9686003)(186003)(1076003)(2906002)(316002)(7696005)(52116002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 42h+ZjuNVri+syhrNDCxDTznnOx3QPcblGUOjj8t1nOFAK2jsLfSjwee27gdF3gmZjLEaR/D1zs3wR26GVC+PA+Xj4KM+B7KgGHPBZ5KBDinjLGJ4SfAI0kT5DZIalmFXCNtBhoT+oGhP20RHDPVB5mDw+ccAuIBL2foodNcX/BR2IokXLb/GXInvPZ0gOn1kfJJt0IXW8s0GbCXmD3bgp3SXKZHPTzGOAcHBsndKrg6GEokLfrX3zmvYp0jAjaqI/5GqH1eQNz/dnSv1Phkaj7HAdDnsfO57J7lbeEl6DumfHms0n/lm1xTM1pO1TZIQRbFqIbPiVe21sYpvt54QKXFY6oGDOBtMmwEUagEhNHgOd2UWrsp+nbysLc/nPtHo2G5waJTgRV6DxYzEWKD53LdIosYoh2ujP2j8pkqapw8cqGfb8LLJHX3dU+/IMzmdchNbRxKkCSnGRU50LMLnVE2pRzTcg7nEA00xCU2lgI=
X-MS-Exchange-CrossTenant-Network-Message-Id: b23bb9d6-a767-4bd0-17be-08d7fbdb263c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 09:58:15.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4Tsg8kjLumSK7EaZbn/0NG6r7ST1n7gu9x4WuateJPbdQLpIlr8jD/CZl5IdEExN3T80HGONP9EYAKJDI7EpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2487
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_03:2020-05-19,2020-05-19 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 11.05.20 15:32:03, Borislav Petkov wrote:
> see below. It probably doesn't work but this is what it should do -
> straightforward and simple.
> 
> And now that I've looked at this in more detail, this whole DIMM
> counting is still not doing what it should do.
> 
> So lemme try again:

As you have major concerns with my code that deals with ghes private
dimm data, let's just keep smbios_handle in struct dimm_info.  ATM I
do not see any alternative solution suggested how this could be
implemented. So I am going to drop patch '[PATCH v2 04/10] EDAC/ghes:
Make SMBIOS handle private data to ghes' from this series.

Thanks,

-Robert
