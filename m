Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE93C1A65
	for <lists+linux-edac@lfdr.de>; Thu,  8 Jul 2021 22:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhGHUMp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Jul 2021 16:12:45 -0400
Received: from mail-dm6nam08on2087.outbound.protection.outlook.com ([40.107.102.87]:46304
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230313AbhGHUMp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Jul 2021 16:12:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THrCOQsgDtYH0GQUaB7r8NahgcTWsKJ6lhtRwlYCzjtEWZZUxwQaHInGu2b/HAEZ1tfMFEtLSuAoJZaVLcJQTl5D2yUWRL8mtbkW8aIf3I2rf9/i07Bc1xERzcgZn3bnKWmgfNC3dEV9P//PpD6gn3QVX91bJBKL1+hbAdWWxSrR9T1uD1cuPAel2C48lTH71d2LtNT3SownibQggNDTXlfmobJoE1T84DbgJHNxwQlC6N/bCWd8ZfrMpZ6ca9E9RX4ppNx9h5LlT9Pq0Nar5yf7sTHWideV6Ob7X/Umo5Lg8tFEaEXUA7Cniqihs1c825Wqi8N25wiHjwqS2znncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKQzCMK0XdMDnKIk9O6DfkLZN3IxxSbvD1BfBrUxhtw=;
 b=n8YlK4BPEXfw5AWKsY9xkKYqY13v73sTIAUvFb/oxA29WgK9bZ0Kckq/gyKJcFXwGUCTBe3J4ulJe4dt1SMi0K9ukNfkvgAIZFM1ZwIYQk7nkuuFUsGTvGJIRsrdUe4QpFFVFjiSL1XeCsybh2al6cNowb5G3rTD889oMlSi1QAJV5u52b5raMHhckFzws+ufTGP9+Cg03BMj4ijvTGVVmsOOjpEr8eJxtUxt1EvevZ1x5g+t4Z/8S20+08j3AHnuHg+oHutJ4LEtP6b2C1iyGBn9yd9GVVc3woOQ4Ik/N08M8jSiAUbCejQ+OgQm+4a1oMeqMQA7XlI/EWAgMFS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKQzCMK0XdMDnKIk9O6DfkLZN3IxxSbvD1BfBrUxhtw=;
 b=HGYF9Pbu0AI9S8rVmbwt4ZjmmgbceN07waQpSU1D/e1TmKXOKcLPVjZFSQz5QBdEN4gZ70wHl5OHJ4oNw90BKpsp93d2jCkwFJo2gQHFx37nnyJqsPV9oSj+duJy5Cr8fVj6p9Is3cq9BflU4Tx9Y7jWofqDVnIF2T+IlDx2BRI=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB2482.namprd12.prod.outlook.com (2603:10b6:404:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Thu, 8 Jul
 2021 20:10:01 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4287.035; Thu, 8 Jul 2021
 20:10:01 +0000
Date:   Thu, 8 Jul 2021 16:09:59 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 09/31] EDAC/amd64: Define function to find
 interleaving mode
Message-ID: <20210708200959.GF15605@aus-x-yghannam.amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-10-yazen.ghannam@amd.com>
 <YNyq95hXKcbM4+Kk@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNyq95hXKcbM4+Kk@zn.tnic>
X-ClientProxiedBy: BN9PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:408:f4::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN9PR03CA0159.namprd03.prod.outlook.com (2603:10b6:408:f4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Thu, 8 Jul 2021 20:10:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0220d372-ca38-46c1-12d9-08d9424c5dee
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2482:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB248298EE795F8CF79D94B3C8F8199@BN6PR1201MB2482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nL39jTqbr7o1i7LvpLdAFSXKa346DQJivBKeUUvPF7zZPUJ7fB1bVXx+hwtwqX1tZdCtDJsmUE3Q6qNDxvDbl/UsgJm5hqdYhYdaj31dDg0BvMDZwaKHliFfd0cbJwD6xEeoBTNbl4NMrxqlcyAQ0h23TOg2cBQ+LysaMNt3SKVZdOMYaXEBmEg3V0s7MUPh5p7mkweJ2A8gT0R1kK7L0eT9wf3GAy5Ev2WxVYXcjGjZcVcSBQAQqHLXDb6443R43nrf3S3Y03vPkgAlsbmMvwLvNbBmkKyWH+wlrOdQdJYojXxnwnehT+Jpw3UKMJhVgDtW9G2RlyYlAtpoPNVDtSuisV5DJvA+ncBFZ7KfdqUK6Ah4G6LZzTHvZlzj78iy1Q1GzngdismbBEJ1Avqcj5LO2PLD2kLmdPQjdQUlCiG7gNQAGLxTP/PABMN73VeUmFy6tYbZdA7DLSYp7fyr8z+Z/FoBgwtgYtN0qGDQMNvPEBsHnGBcA/inpR5c4s0mMTa/4O1KYLJ7YCrZ5dZq+f+uvhuemG2tLAVUqr0XkqNgbQZE6k4XPFAKBB+v6pJ43zIflH//zOASaZHnUuN3qxqyUyHvGMCR3sO+UheRhwkTpaF57rg8rgiLLbGq7pFS2m+R4mzXvY1dKiI7Q6qABb3PdjUlDVoYsQ/kifpeLmIG39HVV26Dg3bMIyCrCTV93CCw+adUAJzMvv9cJHfoVhTHuMdGQiC+5iLGFEG7zlI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(5660300002)(66476007)(26005)(66556008)(956004)(66946007)(2906002)(86362001)(8936002)(316002)(33656002)(4326008)(478600001)(6916009)(38100700002)(52116002)(1076003)(4744005)(44832011)(7696005)(38350700002)(55016002)(186003)(8676002)(37363001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1rYCPE1tTByUBo/nguzefxgv3ycIXK2vvZ3mvHcjlWMgF60q4og1ZQgIfVUb?=
 =?us-ascii?Q?PhvtEUOq42ix0OjnX7nc6QSfIcyfERwjOCRZOSmXckmcntUfzSbfGLcWANHZ?=
 =?us-ascii?Q?OeON8If+bBQyzoMeZcYE4VjMLz+65Gb482Rt30KazTx3Zx/5oBkFcJ4yeRAV?=
 =?us-ascii?Q?BPv9SPfHvWq1q1cPX6PB2zkyJqCokIs7NuaIgt8qgUhcgY0kwvoNua9HlZea?=
 =?us-ascii?Q?iKbn3bEGoRd/hd9h/3186exEVt3wSVjjxEAFvz3/j2BzkvZYFYewOcoKUPIh?=
 =?us-ascii?Q?9FZTeEBWNuTtylef7VYHKLTVV2qOrMSDjAWsVDjNg69ZFH69KyaMkY5d/ZvU?=
 =?us-ascii?Q?fCF76SqzrNzalKdjcaAxWiXFDeHBWvTGdL8Jp5Naq8w/rOa4Eb1tqusNqQtC?=
 =?us-ascii?Q?GRidYHfzh2Q84cIy94lXhXKyIr0Fxn3eqF5gxsPespiwGHaGxjs+YjyCG18c?=
 =?us-ascii?Q?MwRAU9DTqEpiCIfSDOG1IUTmwdgfIpkmo6DF+qyIVjEr4RV3t5uSz4kSnPHs?=
 =?us-ascii?Q?5LlxdY3C+a/WPPuKjl5OloSToO3DtvHAKEki1AC2ueglbMQC7U9ybGHFeKP9?=
 =?us-ascii?Q?wgPFgn6IAqKvBo8MjatWLR0kfab1Aa+LrTnFYmR5KzBXHjOKm0ODvbds3JMN?=
 =?us-ascii?Q?yRQBNDau6M7HMRt/12RfR+pzQUkkV1Q2KEpTJMjcJ730+uvnudLxCvISmFwF?=
 =?us-ascii?Q?IzMRKdik4EtUldbym71XyWDld+LSDAtRzvQHl7yyxDcYBB5Yt8SHrIp1Q+V4?=
 =?us-ascii?Q?1s8XEIufcQ3488au+4Bw+X1RoEnl9fpairPFam8j+G8vKk7T6H1yAsp1Hzt3?=
 =?us-ascii?Q?hJB6BLLEU/ghau5XWjZBzEylyEsCCQKYamR/jgqaIjno++qgYRS99pxLT5d7?=
 =?us-ascii?Q?cenCg87C43VorvYc3iqpHbcD4dFrq2hdsHGLWNqi1R2wSRjw9sTysM0mvIGS?=
 =?us-ascii?Q?8Kur5EFT/oFTbVWp7tp4Yt4gN1x1N/UghHaGNDfGVAqfZVkVDuy1a5C+Qx2u?=
 =?us-ascii?Q?1vKMhqbBVBo8wfpDBw76WNkQHOz0t96fHM8IrTeQSfy+ywb6Bb/oHg3ryaYq?=
 =?us-ascii?Q?0TznvizTdRXzg5KmMCqbixES9xD0F4hQr3MQWFLO2A8AnWfe8+IPNaYuhQe9?=
 =?us-ascii?Q?J01UrC51C7bHJY1CVMO7YSGdl5xlpvpK4YM/SyRaVPtr3gAkB8Tj4cFe8Dm7?=
 =?us-ascii?Q?MTgindejgRA7Oi3y01WIRDqNKwrciAs83qmShqplpcbh6xH9VJLnM8eJT9kP?=
 =?us-ascii?Q?01BTrXMp2kbq0pb25F2KR5IoM6jQ/kGeNm3gm+Mk+62GPqMLMOqzPOb9AyLp?=
 =?us-ascii?Q?LXUzGFjZFEu6tT/TK4W7y8Nr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0220d372-ca38-46c1-12d9-08d9424c5dee
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 20:10:01.1826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgremLneK/suB5jpbpmq1C0ERPDCe8ynzbMnY7B9vZkd+CeIJncJTqa63O/qEEpfKs/AHJGlsyY31M13DC+Ouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2482
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 30, 2021 at 07:33:43PM +0200, Borislav Petkov wrote:
> On Wed, Jun 23, 2021 at 07:19:40PM +0000, Yazen Ghannam wrote:
> > @@ -1088,10 +1096,12 @@ struct addr_ctx {
> >  	u16 nid;
> >  	u8 inst_id;
> >  	u8 map_num;
> > +	bool hash_enabled;
> 
> For such single bits info you can use bitfields, like struct mca_config
> does it, for example.
>

Good idea. This particular field gets replaced later with a function
pointer. But I'll keep the bitfield idea in mind.

Thanks,
Yazen
