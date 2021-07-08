Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD73C1A37
	for <lists+linux-edac@lfdr.de>; Thu,  8 Jul 2021 21:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhGHT61 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Jul 2021 15:58:27 -0400
Received: from mail-dm6nam12on2071.outbound.protection.outlook.com ([40.107.243.71]:26976
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230129AbhGHT60 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Jul 2021 15:58:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1YvONS4PYEqkozkvx3iYOuSODOZW+QjZpngFJphM3hZQu9FCDNF/ZOXrXvFSnXlVtHqvT46TduofqpLP2VuTIcb1Ti3SotP3HCPNf7a6lUKWOkY9XZTa2mgS+zd8dIz4nbzOv37Fln+20o+81OIgqM5fPAu8VvnEquixlmNMXy00p2xFFq8HaiXjH4f1pE/vG2Wi/X7cj8O2ohEo5tb4WeWrzjnALGl29cXjvBVS/iwgdeZlkZ5h5w/bodoBc7AbjyFanDeazazp4hgrzjkZO1rtUj1N+BxB56WOLsUSIx1kZFnhbMcNnMnz98is7PJHV1qtvTmv7Fdj0RIqte5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix+zPGpNdTIoXBNJAx3pES6Jfa8bYnFIz0CRPud8GGQ=;
 b=ODCrO4jXkSh/RJad0XwPl8JzOG8VQya97qBfjFkV1tkbUoalllJXMw7yBBShN/nteBHzqCqiS9PYiPGggFMCHkHG1QXomqYXkwDSmTSCuuJjlAIDiNHn+lV39N7x6hLCAJODxR1+ezUUtQcEhalRjdmLtYa4iQFb8FaOGQYdk7Ero6laJ81Hig/WnpmJlXVDqAXtlHgWmli53m3BwVrdx5ifNvYW17v5osUcnTS6Vx7JoaBd0KvyAhWCNJULqRXZfnocAGcrkPw5VlxaNZfo7a1UTf+u4pTpYK+aD2bgha6x+hY0SO+RNwDwlVwpB6uMdDp3MxsZVjdyC8APfJoEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix+zPGpNdTIoXBNJAx3pES6Jfa8bYnFIz0CRPud8GGQ=;
 b=OCc0Q4Fk14B6Kr+peyRepmZcla2vxXiLYQ07l7GZbb4QzYXrQNvJ/GXCuzQ1ocUbNbtVk82xFalqMlMek3gPXXa1re/Pact+V081X9CiCFxtrcVNNMrW3+WowcK5u+pOn3/i33RGzAXw89cZTGmwzF1X1fj4q1QhE/YDNHa6Gtw=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3539.namprd12.prod.outlook.com (2603:10b6:408:9d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Thu, 8 Jul
 2021 19:55:42 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4287.035; Thu, 8 Jul 2021
 19:55:41 +0000
Date:   Thu, 8 Jul 2021 15:55:38 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 06/31] EDAC/amd64: Define Data Fabric operations
Message-ID: <20210708195538.GD15605@aus-x-yghannam.amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-7-yazen.ghannam@amd.com>
 <YNynsT6J1NTddv0z@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNynsT6J1NTddv0z@zn.tnic>
X-ClientProxiedBy: BN1PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:408:e2::9) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN1PR13CA0004.namprd13.prod.outlook.com (2603:10b6:408:e2::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.10 via Frontend Transport; Thu, 8 Jul 2021 19:55:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b23907d7-d157-4df9-5c74-08d9424a5d83
X-MS-TrafficTypeDiagnostic: BN8PR12MB3539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3539E8845F52A8A575AEA65BF8199@BN8PR12MB3539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2Pfaf5vgez5FCS7GvQFy0xalAtEh2H1A4A37aRFtc4t0me5OFrHIdv8YDceI8UmmTkGcpE3slBI1AX2Ug6zhJytTNkWmHYGfjAnAYy2EXS/H4fuYONiYMssBT8fp9GoDjIZU3BRh4s7iO/cXY9NVxX/I/7OR25u17Zz0NTpcdtBeGHKpbkul9WHRXZbj7YT19YztUdQu04ebQT33tY6DmPbLBezwuADtJJL2BJqGTDFg1fhgWMeytlqwztiJKLl861kfx/hDuHPFqWIb8YNx9O61OxNG/QkRuIqHq6LDRfL2JnuUOswgiwXpXzbFvXB+tu0AjwrjuZm6D2MUvvFQxJITL+00rMQG4RHSkne2n/3tQIp6waOcmq7IeLnO8yyUVJgt/D3/pgkIprzKnv9lU3xDA39FG8U3MP4j8NfOf4qVM9iJk9kudF+Er5el8VGQSdNk+Gra9Ei0TEOEkCAwxUaDubhQfZ0VTUNAEoO0q1iISd+CcyF3GOVN50hu1ykgzpMVXl1oUYfnHn0m9crRqY3W2Qkzq1d5/LwA6TSQ0uI4Y7JKxXLJ8REyPfRE28g0zz0Dc4BZTUaAfW9bMsTu18hM4Q6D6iqWRoRLCQwE1+NLLjzahTlcGRkXTPP5OOH3rCvUPr1EjG1G2jAj7gCn+PfShdy8it7NWjGwk9fqYthvyC25CSac3sHXf1T+rebm5A2l6dYB5sE22XSMLD1Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(2906002)(4744005)(26005)(33656002)(186003)(956004)(6916009)(8936002)(86362001)(55016002)(66556008)(478600001)(1076003)(44832011)(4326008)(66476007)(38100700002)(5660300002)(8676002)(38350700002)(52116002)(316002)(7696005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WD6MsJwuqk/gdHUrVBP9J7oYDo1+ENZ0wB32WZqhJj73JGFgPb0pPuIFsBjr?=
 =?us-ascii?Q?3nGITGnfj2bFnPQ0PIgY3CA1TVfc5H5TZ1r8aI6W1TW8Y7E+cdEoNBhXab52?=
 =?us-ascii?Q?mscnaWJ83cEZUYN1/gW4xJ+aeqtu1hTPTtvW5hFmV57jbc439/Z/8j/VxAvY?=
 =?us-ascii?Q?UzTMpigeV6HdSOz2/7DxugL+ay7/yNpJKfDicq2IXnrBVrhYsEUxLE5YS6ak?=
 =?us-ascii?Q?J7rmXy/UXgUfUuB/gdrGQ00Xfv5dt2kFiE2hLAfP1fzS/kGgogxOBdg7c290?=
 =?us-ascii?Q?N9yHXUi+ZZSUJO1++MMJR0/ZNPD77wews1g6jobx1XMxxTiJpi46x35+6uV1?=
 =?us-ascii?Q?3ZvkNJDRVXhFuPQE57g/D0cPDpVpKCT0CC9FH1mPy1g2+UVeDAr1lXJAKrm8?=
 =?us-ascii?Q?I4VcD5Fpj4xmRdMN971AcRGBc9WGJTCL1ME5P0xWaxc15Si+Lah2rj97GvqN?=
 =?us-ascii?Q?W4xd5utxjZdxS/SLFoJCAyUXEAH6gICEZmvMTKLzat1tLOLlp77ekm3PK1zs?=
 =?us-ascii?Q?J8R+JTKNZlJHLbSSU/ZS2Fg7kbqS0LbjTKC+mcTaGgd95S/LEYVrqonSsvmP?=
 =?us-ascii?Q?4tA4I8tSuq2CrD0Oz2YXuDfSEZVmI5Dgf4qcTG97F+nZUE40hpLxJGBQfFvQ?=
 =?us-ascii?Q?mUdjszpSHdCDpB4o8cJHFtcr6TNWCypyZ8esnMXAEKpmlinSUCx+PkOYdmZR?=
 =?us-ascii?Q?ESvTbDITL10/R324UYxeb/InZX2pGIVFhNVpaUWENj0Etv+SzIko3PQhU6W7?=
 =?us-ascii?Q?p+8Qh8r7i1VrSzmCJbRse4jGeETlcHiC7By9882fYc4laEfFPf4TcT3t3bsR?=
 =?us-ascii?Q?aA/noII7q/sGBk+vzCHA8ds3KkeMhZWSA48UNqIP8xpzfFetiDVpvgf+qMNf?=
 =?us-ascii?Q?3gceLZ0NA4YyCPGDY/ObPhUzOwOMyRFVgh5sDIhckuvhhbUmQqMxuALWDvc8?=
 =?us-ascii?Q?sZrv6dpTvT0Id9O+/PnLnLEDXx/Hi8Eno8y78bkkYzvmtPbtw29evbcojbj6?=
 =?us-ascii?Q?k4Hd0BN2TIBla9l+vr3iIN9dZdAdC8hEcNhoDRzNp0I2erpjT/44+6wNutXI?=
 =?us-ascii?Q?KImXRrYuBvmRxPCespcjmmiNHD/6q/uHGKXoONme6zCh5ERwIYlK3JzlDBMF?=
 =?us-ascii?Q?a49nCa2vy1Ii9a+UwUSfCUCH+jnm91rh9JoOfpcNhYDV4Xj1QhAJVcA3f+K0?=
 =?us-ascii?Q?jrvWhodxooa9K7gq+UypXkYWU1Gg4Z0Phh2mKoJjY4F4gCwS3PZSfKo2IPhz?=
 =?us-ascii?Q?LPiWYSiZ45XK04AQgBS3oNAiX9452L7DGcVcrjXDx4ZKQZreH32Ld3+nORyp?=
 =?us-ascii?Q?8cj/RnWooQ4Hzrc4H0b1B8PS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23907d7-d157-4df9-5c74-08d9424a5d83
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 19:55:41.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ8wAxOOTvesKj57aFDSCzqkGYID9eXmqZmW9N19hf6XrVEPSkSj0LFIWELYxdDSY16RhN4eGrFDlVjFOT3gaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3539
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 30, 2021 at 07:19:45PM +0200, Borislav Petkov wrote:
> On Wed, Jun 23, 2021 at 07:19:37PM +0000, Yazen Ghannam wrote:

...

> >  
> > +	if (set_df_ops(&ctx))
> > +		return -EINVAL;
> > +
> >  	if (amd_df_indirect_read(nid, df_regs[DRAM_OFFSET], umc, &tmp))
> >  		goto out_err;
> >  
> > -- 
> 
> Why?
> 
> You can simply assign to df_ops as this is all driver-static data.
>

Good point. We can set this in per_family_init().

Thanks,
Yazen
