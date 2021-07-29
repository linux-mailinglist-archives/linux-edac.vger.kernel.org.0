Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA37E3DAA91
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jul 2021 19:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhG2R7u (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Jul 2021 13:59:50 -0400
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:28256
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229485AbhG2R7u (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 29 Jul 2021 13:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2rq53Crdf/yPbUYtV9CsgsuIkjeZYNLk6qLuIe/qnC78i7rlydtVeOKPF4itXUibTs5mn0m34OWn+LpZb1hT4h4jH28t1f5pkHoptwyccEeP5lSUuUtOA8e3lI+LCBwA8Xwt+pmAFPNJkMGXj99PQ1Gjc7Ts2ZpkAZDWRtYFJTyKZALJ2+LNyJd/kCBGc09IyLHwxLxbW6ATRjoJO0s+3cf1mSIl5QkC0bGji6EIsSQCQnC1FyNsgYrluNoDiCwftjfn9GdqzS1lsk7EgnOnUwWGU1TnPDNcC01rjH4Q32y1xgKLmP1PvszzDGkC0uMXcKRAR7EeNIuBO5mWNtkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2qy5cP1O2jwpqchfspmO1F1PARqHfgiJCRwlGOzsjk=;
 b=hGzua4HGTTHtAeplQKdYht2ncBwTQH+Rp6F30fWbF/4l/YvKilUdgdyw4X7xib3EQwhpn/UfdyVIMdcWIYXiUWVXu/d6ePjvGbZtPArcXn2MA19Y6WhXMZiogEXDJkOL98i0i2WoRe13VkENrp2kpHW7WpLmLeoRigE45fViA6SWJxBL5V+n1bODKj5H8Q0UOcWCCoxgWr6XFBfnHkabF2h/tyvnpZAkUWE5saTu6bjqSPpAmEWdm4DbX4YkIpCE+xaFL76oY6mOHwdOO3gLsABoN4d6ZAnToe6LRj6nPUH/EmkdkzBotMDk1wzX4J+x+Q4pPQEujT1ceyIRvfG5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2qy5cP1O2jwpqchfspmO1F1PARqHfgiJCRwlGOzsjk=;
 b=4F95D6CGNMc1p53aj8uBOBeIg1ETBndyYnNpAIHp+Ii9WxKJ97G4TbOZ51H6EQJGNT94r0YoTNFCnxQ7P1w7rG0nwRAw+G4gTSHth8J3ggJ+1ez9mrhuzyLJcwExn1PiCEJCIO4Zjz6R01mrr8fLTqWHjz98n7GX5o+PuC/0tw8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1809.namprd12.prod.outlook.com (2603:10b6:404:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 17:59:41 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4352.033; Thu, 29 Jul 2021
 17:59:40 +0000
Date:   Thu, 29 Jul 2021 13:59:38 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org
Subject: Re: [PATCH 6/7] EDAC/amd64: Add address translation support for DF3.5
Message-ID: <20210729175938.GC4318@aus-x-yghannam.amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-7-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630152828.162659-7-nchatrad@amd.com>
X-ClientProxiedBy: BN9PR03CA0651.namprd03.prod.outlook.com
 (2603:10b6:408:13b::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN9PR03CA0651.namprd03.prod.outlook.com (2603:10b6:408:13b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 17:59:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad6ced44-d487-44e9-eb32-08d952baa33d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1809:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1809B12251632EE68BF02C13F8EB9@BN6PR12MB1809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPgtEkFSSRE+ZiZa9p4ASdFv+DxsyUFYP91Ail74HIL9ohzAZAt3mM3/hD/6sg8oT1ckmfLWj5Vv5iVfAyBOOS1WbMOGyqFKbn7Swv6hX8/cw1W4hCT59W9VvenhAIqE2V/zC906DBBSbTACD1D+7nsYmcx3xDKNbt3UxQRGpuhItI71JRmJQe0kOMVb1Qc7lmmL0lQMmrromEU/IRfWJbQ2sPTXRIYGmZogbMO5VFPUGvdZVFGgnMFrzD59kxVqYSZpMEqPHEsewtWAiA8Kq59HBiNelGzqDk7QWhjgZAa8RRw/EryxHB4j8IiBs7TadTjP7lrslXDbXyGu4rTJL44XU0x7NbAiOb2p8szxFSJqnkhqeKs0Aam5+N1RcxDC50Xv+1ItVo35snxltgx/DbJehNVRuuuIagmw50IAHJ+utuKi97yACKoNgv9Zm4rksLYkYVthD+EPjSRrVJA5tLqkFhL2NSJKCfN/2qXTJG9PAi8kjZLhlzJoZ8Zgiq4AXTBUh2z50LYiws2IZ9yv8xLPlnmM45fg7c410tmcofH+zlqReEiPQnxEvRtRm4XndJgrX4vzOQRq9KkqEZVowCcCTwFemQdlUCj/+rroMKCI46GYKh7roCYM6aqLf7ZyjNOg5tzSt9F3w7xjGGef9i7jIly/5DeTToUWdgnBSxirBxXQm0g2ldXhfr2RpsXCZKWY0NRuJpCKVOpe7UcgBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(44832011)(6862004)(316002)(4744005)(26005)(38350700002)(186003)(66476007)(66556008)(38100700002)(66946007)(2906002)(8676002)(956004)(7696005)(52116002)(86362001)(55016002)(8936002)(6636002)(5660300002)(478600001)(33656002)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wz9p9WrWEpcqk4MUWtEFSo/7KPlm/bDv7aExKnO4OS9HF0P35wkERzLRhsQR?=
 =?us-ascii?Q?ynBD6TKtQLal5UbOorqEfglg6QJf61iVIDuKZrp8MglNyDL8PItplBpogPyJ?=
 =?us-ascii?Q?nNcta0rt+4ZtUDGG7jeJ89zJMj4Rluu+j7KZFhAODzASHKBlAOYypMSTKsrO?=
 =?us-ascii?Q?hr0d8DbVlstCiKcrnqLOWxOV6pIIs5lhzQyYoG7dSUbuqEBWbJZBuWL+sXvA?=
 =?us-ascii?Q?6fcifFI/18fVihuPpFjWrOhs0p+IzqaM5ge+L/2epijIdZl2jO63Kbo58oNL?=
 =?us-ascii?Q?FoVWE8SFc6xunTKCLUWL3IjWY/SOdVgO9cPo67Z7RHNbmOfDVVSwc+nOlQsf?=
 =?us-ascii?Q?t+3PqUZ5H0dW/44U3+YkiS5NBc+Pi+jkUcIypsfZ8bxDDYKx1pfhgJoYBrWX?=
 =?us-ascii?Q?8DjjXwATxvGfIdSw0IlGlgzeuZCsjlivU667nT6aIjpb4EEV+2j0YeboAMW2?=
 =?us-ascii?Q?BDiCwvhTvvH/cOyMMFSqMshauAtupygC1Y01Dxe8t7UikaqH4d36Bu4zDndF?=
 =?us-ascii?Q?VTGazeb+eqJxrxAWp4qHk15nTPOvUg/8DOpNnWVUgZTpnSrMzYGIjcH0/04p?=
 =?us-ascii?Q?zEJ/fqiI7Ji7xO0is1k8cYkUUZqhdD8dyiI8t7GNKAuaWKc95NiXOhMjx4sy?=
 =?us-ascii?Q?Q6vnYx2ZMxGgPssbeUrfaDXmF08NRGNqh5cU14inHlhuljbORhG4oOpz3OQg?=
 =?us-ascii?Q?eAeuiSyNm7bxxrLiGoFj8ds2L5GXrsFI9p+KOtlXLaxslHrEGTTk6cNrNKF6?=
 =?us-ascii?Q?BwpG7HfyaxCnLcEJx9sTCGLzIo7mq6mrWktoV456fQFNp4/tB5/YxygBwnoy?=
 =?us-ascii?Q?3kAozU6Nq1OBOAXRgx1JsrlYoMGKomffmPGYtkdCCEgiB1is2SqlnCPvc3Jk?=
 =?us-ascii?Q?9tbpHapR5cywypgMS6SbYJURm/9bEVc6fYxWmGh3XJQYSNXxSidFJaH/INYB?=
 =?us-ascii?Q?0sHCYHYOo5jRPiwTOP+xKlYwTDgdYpYG+B/2DLogmrtOiA+ltg4q75bcehar?=
 =?us-ascii?Q?6lqjLZWuhurlWMCVn0TfN2q1CgZZFohyM8ZL5YOlPmQSvzOnayMpW1OsaktO?=
 =?us-ascii?Q?a+3ZLm14CcoKppb0EVMM/divrpthILp9Ag6334S2Uqfd1tp76XwGavtbbMTm?=
 =?us-ascii?Q?VV5msz2jdQzVDDi/FfD8DoZK1MHw+abVAeQzboSuXXQqSqJUrbZS/At3uxdB?=
 =?us-ascii?Q?FIbDnU2BxF2CZkqUs5E0feEEzcAF6ECQgKFDAVZe8+gcOqEFiQ2gqaEjZiJL?=
 =?us-ascii?Q?dRdOx5o9pEg2hd33bd5eMygj5pwiJqHwUMMKenMp94U3pECvUODey8CeqLNy?=
 =?us-ascii?Q?qU+DYmTvHGcCPMRvFFJli26n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6ced44-d487-44e9-eb32-08d952baa33d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 17:59:40.7173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1AuqJRn0bMyuee2mJZQvqHTbRejA+sVZMrV6mHod5HxcjrvtmgUKvCCfueuN7MbLo2AAW0prT/3fjRXaa/W2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1809
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 30, 2021 at 08:58:27PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add support for address translation on Data Fabric version 3.5.
> 
> Add new data fabric ops and interleaving modes. Also, adjust how the
> DRAM address maps are found early in the translation for certain cases.
> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---

I think this patch and the following one may need to be reworked based
on the changes in the other "address translation" patchset. I can take
these two patches, rework them, and include them with next revision of
the other set. What do you think?

Thanks,
Yazen
