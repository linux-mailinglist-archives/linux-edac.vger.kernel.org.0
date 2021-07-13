Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA33C73C1
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jul 2021 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhGMQEl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Jul 2021 12:04:41 -0400
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com ([40.107.244.48]:47653
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232912AbhGMQEl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 13 Jul 2021 12:04:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+n53BW5clKXcvsUMZxmtY9fjPxbqn0wjQmlDSGzWn22SjzldGd9L4OWocZm7hWgkHICzi48Rau1fSuqc7Qf1j7vLxiVk5ztz3bvfo87GDrbNjq+THU+lQ57JXVtU6+s+f6Y6Msh5bemWi+4MAgR0Jv7WJUXPSuhRwEHL7zi5O8N9Pak5NN2X7rEr9m3g8SkqNDbpUGb2l7BmQvy5Hqiy0c4RB7FX4BuiyGoN2l3ud4HeRr+w/DHajCmjmtzW3LMg3fWDKqoI1u4mCiAIkQ3ZpT6LD49fJ3gSK7zgZHkFwuLtaks4nmqmhPykMV3u/pZA1CqGhj9wJUQ4LvQOeTdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCQUjTq39BLSM3Hp3mYpnsrIy2NpRYMskCNGk79gpdc=;
 b=DZoX5GbBl01rxoTT+cqHK270Bk5AUMAF7BN8XOSIUU/ObgCUNnwNRzdamUi5Z48IKDVQZ54CcLiD0Guh3SMaOhyokCsvTy7x9stXSis8Y+SmerA+B1+gZ7isShtVD0cu90Idce1fIOfWsbyLlbl3kQNdMCh0UF221JWIktd/NoB1UOFSoYLtGBf7ObhljQ2MDR0ZJCGRkSZY+Z+kxwUbJUPWHRlvxtCwSxeGPWdggcfMTZXSG5xX/tdEOb4k2CRKTid3dlAAsjaKYOoOK+c63rYd6R+/96kMYIiv0kLcy50qm9VDnMuk4CklKqOKUrD2pnXHizrS2jdzlwT5px3wMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCQUjTq39BLSM3Hp3mYpnsrIy2NpRYMskCNGk79gpdc=;
 b=mqEJ01qU7KmbMUvYn5TDnRjsuidoJsBRKudJGNf8dXxgfgM9qQP2s3XDXUW1gBIm5A+TXTgDE8lURIzbYUacki7ZFIOkRmQ3tC4r6a9UrKLTtPm1Ri2GsMinl7bn2LbSZapp28EZMAu4tm9Kmsz+Ad4MFD1hHq/Jv0amAfTHRtA=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3603.namprd12.prod.outlook.com (2603:10b6:408:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 13 Jul
 2021 16:01:49 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 16:01:49 +0000
Date:   Tue, 13 Jul 2021 12:01:41 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] EDAC/amd64: Use DEVICE_ATTR helper macros
Message-ID: <20210713160141.GA9752@aus-x-yghannam.amd.com>
References: <20210713065130.2151-1-dwaipayanray1@gmail.com>
 <43f0eb92643a4613992714effefed757@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43f0eb92643a4613992714effefed757@intel.com>
X-ClientProxiedBy: BN6PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:404:13f::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR14CA0028.namprd14.prod.outlook.com (2603:10b6:404:13f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 16:01:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c45576-7856-41a9-2564-08d9461785a1
X-MS-TrafficTypeDiagnostic: BN8PR12MB3603:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3603D17C7B33C5B46E067D6BF8149@BN8PR12MB3603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZELfXy8j8fyw1Hhgp/bVjydHh2eCo1cnpMelbO+HkkN+nFpiIQ2GevTRsPpynRyU478IibJBVBUuEsL14tAgvwLy3vKMH6/7GXBOuoi2ix4OxxsGrwYJ0RoWPC57r18D74CI9GzKot4WYIIuJY1U6rgOFWb+/e6ING663KkN3G6wuvcmHLCU+ohssACciF4PRmtWFk2k4s4pkLlut6Osdk0ikaQIh+0YzGkQWEaxabIbBBqqdJBxTcTlFOI94J1ys/Wbmmv3ZedqS9zOYp3JblArAf78FAoG1e6yshfebmBIRYWtquLSzDwFh0b5Nu1mlk+MbpE5z/gt7dV2mBmAEmc07OAVb8FderuFeiSFVcgf2KHzBGXwaIcaShdEyWWMwkuQVy3OrCqLarSYLoGGeOqhu2iJ+w27gmGePm1F8m7eXjEPN9sLobRl83y/Vqio935WUgvkUvcLNOiu2zPJPYh/Trgl9gdrY19+bYvU9AJJiwYVRGqnySJUo0AkE0hVfV1h1iMDuq47ptjHqA+BRw3r5ClplI7OJTp/ZRzuPPkeYxs4kjyww8M+A7dpj2paliVg/rMXlJU35YsIfofpJS1o8K1/r+qamt5r4K8eiHleuI6aA+L6bAW+gzzu7ZeI6FOo5zd2DUd7UL158ifS0d1VzPkZ9XCZbaIW7tyQVI2d4gjlQ2PXz8iZxzzyqmL2mzSffZkyhIXwZbAYri6xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(186003)(86362001)(8936002)(38350700002)(4326008)(5660300002)(8676002)(38100700002)(2906002)(33656002)(26005)(1076003)(4744005)(316002)(66946007)(52116002)(7696005)(7416002)(66476007)(66556008)(6666004)(6916009)(54906003)(55016002)(44832011)(956004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dspXVpodl3QwwIipT8Ddxpy9V9TYEFgegIOuKYmluwqKFph0r9yIg5wfbnKs?=
 =?us-ascii?Q?ZiEXm/EMPAaUzxevaicrKyFyKMud0N1Cjg88ZymnENlhaC4Xc+sdX0HiJuvl?=
 =?us-ascii?Q?/zxQwoJtlgIJ0YhdacMQ4UW2vFOTTMWn3ggN5iU6/UcZShyzbLhXPW7d/5s5?=
 =?us-ascii?Q?MLvZnNO+J0pmeh35ZdvFN/j0sxnnApYY5BRZ3x10Vg8AocZDLaiRgUqEUtar?=
 =?us-ascii?Q?z3rJnsFTJJF6kYBLp9WQ9NSEZ+qlYS6Et0jL3E9FReD+isrjtCx9Mq4altwG?=
 =?us-ascii?Q?eJ8Kqp4j897pYPGKZaCwBHbLrG2+lYH+g8FqYvkzJG4wCWCmhbimePLFBb49?=
 =?us-ascii?Q?tRYnkAI0kbjJIBUTrV8yhAiVn3pKrtp4hKqhyKnshHUXc5RFNmZneqadR0Zp?=
 =?us-ascii?Q?+Y57VvIqzBBHONam81OzkR4Mu3uHKTYOlMD0K8Cr9LN9oIfAAmdaN6d1YWvw?=
 =?us-ascii?Q?9WxxqgTBcF2tHeHXnnS98kGP+xZL7kDTau42FnXZT39AXKOe+ifIvDX1b8O+?=
 =?us-ascii?Q?bGHcwyDitb1VbTJnoUFm1JZ7X3Q/ooUdOjMrw96PSE30eDkBJnmE+5jCYsgW?=
 =?us-ascii?Q?C8Na7KL1WGZPv9qhijeD1SrXE05U+O41lUQUWKvNOvpPZVkDL0ZP2wToHns+?=
 =?us-ascii?Q?ZHZpoO9LLKvGv3XirYIah6KYwtKFKa7eOgTCq1speQBJ/Jmwo8bgaMMZa36U?=
 =?us-ascii?Q?N74rfHrtFwttm4Ru4cQ1QlqQ88w8ZwHnPJnlujPd4054rEWF0O9wqY1+H9ox?=
 =?us-ascii?Q?z3Y8RfG6oIlle7BinA11d/3fMTe62+eaZT+hWf2kbFxorHcluxYbf2TJj0cq?=
 =?us-ascii?Q?pPcUhy6R/ymSi/lnQ992Yqifx9uYBDc/RKtoT8It8q6DNpT51bj9Jtai90gV?=
 =?us-ascii?Q?1rBChgBFNkwmpbYJNl0lTHsDR4nu1LVxdmHOoZOY336iHaky0fbtHp6vQSek?=
 =?us-ascii?Q?6G2Qtjop50NnN0Qcynd5+J7IE0qrHIdkzfp51Vp1in8Zcxl65ieMzD1BNJXi?=
 =?us-ascii?Q?Im4VCyyO5ykV13esq9ztD9R+59fUnWby1/fSseKm65nHUIkYqsrBoO5SA2Eo?=
 =?us-ascii?Q?SkLnR0YmMg1Blhu0ToVlstyehN+vwIsEq4pOdpnocYQOFmgpKh973k+5W1bv?=
 =?us-ascii?Q?pyLgST0zS2RnQOtzBAEnM9Dm/Y515e2BL8MvKQbfAnhAB1FW73+xUVIdvqLT?=
 =?us-ascii?Q?rUTX/pRGO44PguRBFn6b5IS4AJunapy0YFUETfBn6ioINuB1W6YIBoQz6Eah?=
 =?us-ascii?Q?vJXjgahTa9hl3T9D6hi+RXsRT9q5sz6dVeK4XH5u5K8gRn5O1qTU3YgYj7lQ?=
 =?us-ascii?Q?cKqEiesgHUueMpmOiTj51ayC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c45576-7856-41a9-2564-08d9461785a1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 16:01:49.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iPTobAlLMzDefkt4dmI401w2pVnYgVQ7+fp5V7vX2g/oqaFEUgQVF9OHFLMwkCihoCYMzt9WzFF+5r2Wvkdbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3603
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 13, 2021 at 03:27:01PM +0000, Luck, Tony wrote:
> > Instead of "open coding" DEVICE_ATTR, use the corresponding
> > helper macros DEVICE_ATTR_{RW,RO,WO} in amd64_edac.c
> >
> > Some function names needed to be changed to match the device
> > conventions <foo>_show and <foo>_store, but the functionality
> > itself is unchanged.
> >
> > The devices using EDAC_DCT_ATTR_SHOW() are left unchanged.
> >
> > Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> 
> Yazen,
> 
> Boris is on vacation. Should I queue this change?
>

Hi Tony,

Yes, please.

Thanks,
Yazen
