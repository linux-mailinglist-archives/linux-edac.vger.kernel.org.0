Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE473C63E7
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jul 2021 21:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbhGLTrd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Jul 2021 15:47:33 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:35928
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236482AbhGLTrb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 12 Jul 2021 15:47:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIfBdn4qWK3IXjzRvV1z+NryUO+CiJdoZtKInqXpXQTb2LhnIGJr1PEQqT7zUrBfX3OenN6yw7rdim5hNjVWfM15ldNBuE0ZjqzLU40xYZpavS+LWBj2DXfJZxNBh7sY+O5VZGW8wu/BJCRdz+OoGuf27/jtgCtXaayfoye/Td+FihlqkdmD2cJfwkiRi1Y8dbCwF9DMWGc+85h429AFAqTsENRbHnzStudivuf2w8wqR4Wrr6rKREXGHMhfO8BbxkjzXc2I1KZcYCKDPNvRmMPs4CLkfq3Dz8Qh8HBsWdY2iFjn8PurraS12g7/R0Oy7YWxTwxCHsTJKrX4uhDd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcHX1A6/n9Uv09SDg2bC1xL0N0p5LSp3sk84vW1s+yE=;
 b=DOX9kBKBDO3xkl5Lqd6LsV+f2fXz4z0c/n5jIEm8QVsj9Z4oH0RmQFzn+09c1Gb9ygmXqxRBsoTL6C4ePXvx5qNLMQs3eufocHqVWSU0T0WvpSVKaOcWtQFqXKQDgK4YAzkdEij9OiOiBGV+OU7UBdxF2iooMd6ToLhwx/iZoAyQAye9qWxjw+iXiDT+3x1evP1iXLNyK0g2sgraNFeNOh8o/Ftxl8YyMtRVQIAHZBxweQNqAxjANvq5BnEC/40OZTXTBp3+0bXw1ZhacU/nT0PwOMXNFGui6mcsNCttNjyyW06jzeHEEiwt0044CKXAcTNs3UzCnElBxQANqs8xUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcHX1A6/n9Uv09SDg2bC1xL0N0p5LSp3sk84vW1s+yE=;
 b=FI7SKD9GVVGQujh0rbbBiVwPdzJDDbtOGfqxQwHccnYSA3TFo/pm2eBAS//glnu58a0ntwzmXvh2lk68Gmju5PaJQ/HlF5PeFxCUjuLUHYoqxPMmQokmxAnPY89vtyqceO9uKls55sAMEo9H+bUixod/5EkmAtD5onwFaYxvaG4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB2481.namprd12.prod.outlook.com (2603:10b6:404:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Mon, 12 Jul
 2021 19:44:41 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 19:44:40 +0000
Date:   Mon, 12 Jul 2021 15:44:33 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, lukas.bulwahn@gmail.com,
        kbuild-all@lists.01.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v2] drivers:edac: Use DEVICE_ATTR helper macros
Message-ID: <20210712194433.GA1002@aus-x-yghannam.amd.com>
References: <20210711141002.103445-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711141002.103445-1-dwaipayanray1@gmail.com>
X-ClientProxiedBy: BN6PR1101CA0012.namprd11.prod.outlook.com
 (2603:10b6:405:4a::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR1101CA0012.namprd11.prod.outlook.com (2603:10b6:405:4a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23 via Frontend Transport; Mon, 12 Jul 2021 19:44:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b094bcf-5b24-4088-6090-08d9456d7d51
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2481:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB24819C441ABFA3B263078EE5F8159@BN6PR1201MB2481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kK5xKaZjnHVGaWpahpmGq1Tr+5owOZKqlPxAJOqWJ/V9KvAnL+tPuwUOUHhVAjVkHSkTn+ifBQfYNk3KJ0fSZMdemlSWmZ2LDAdmqG04VDkCFriRsDlje5WOp21NBIuVizJDr0+/Qyx4JkrxWZc+zwv59+TImaJLlUr/h0V2VBjIB10RXSTydnh4yO0cJC3aeUGntpllsM2rxW3T/pxaeTkXtRM7WEjcsKOJN10t0zaojRCUUWWnCLO/E5nrKfsfStz44rY6D7/psKt/mS3W7BktiubJ1/S1L+ykmdN5DykbN6Qfqt5xivUa1jY9bzBTY610KXx0yp9CydxSUc84DN7eka0F+QjfxuxerYBIqKColNhCDSSrQVh0c/dLEdOeMs3laPLmkB2uv/9668bwufsdOssVE34+FX9sSgbAAMsxPCd6DPJBGDMTSuK97f7WWTLIf2dq/zvW92I1urzYh9RW+e7/1LXx3HQYvju5MT+7hFaPwvHB1Uvc/stIScYP46CSI9lLAP43qHaVSJMGgyw1YYSx9XgpFFZAA4uHUOIzOvkBjEMGR8ibqG3Uflgz2KjQG0l5KAlYs3ChGEul8+1UEtk6Ddb3ys4IASX0oTy/arLsdZKzEsIso+wLvVpUB3aRAM2WXoCTyUAy3lnpx/m4U0l9qChfTwWjo8i12MgJRtpXdX/04SXEraj0k5z7mt7GpPlqQLR8IihnAXFA9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(26005)(186003)(478600001)(5660300002)(52116002)(66946007)(66556008)(66476007)(7696005)(4326008)(83380400001)(38350700002)(6666004)(7416002)(316002)(1076003)(2906002)(6916009)(86362001)(8936002)(44832011)(55016002)(33656002)(956004)(38100700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yt9/t2BGy8tICt+t2kLfkr4GYlhmF51tkXgu2dkDe6pM3fuPlDyacKfuhWSs?=
 =?us-ascii?Q?Q3eU14wdadgMRdxZh2JBPvNiLDuDQfZEPzuQJ/oGIKXfiqkNA6mPEqT5kxk+?=
 =?us-ascii?Q?TLejyWuO/9XhNp6uYUpyUthg5kyNQnK6zBYim5pCL4BNrNFUv2Xzc0mLYS6t?=
 =?us-ascii?Q?a7eAjnj2QYp4ooW051n+InpEq/Q/NU1qzQgh2J2AtBk2wvFYEQQLtVF1tezp?=
 =?us-ascii?Q?ShMnsvJMbF54KjzgJoWlyTjg5W2+apRkateieqsM7JntLmKUPzRp6LNkENwq?=
 =?us-ascii?Q?EYTOSkjvdxnEbkAGAiJ8fTxYEy5jGhIggfefm1PlaAqwl94ptmyH5zHxXNHu?=
 =?us-ascii?Q?Uw+lWc+uPi/I7mUQ2XwGwFmn0dB/06/39tI0uj+9RTeAplv3f9kaGywVZ1VG?=
 =?us-ascii?Q?vkiebqu4hBSlBbgtFWvY6tDgCBXfPDaNQpWj8PtSwdBQ7L/n+6oQRUqbXd2S?=
 =?us-ascii?Q?eDitk31YyxmV7awZOYy1QMJlx48S4R9XXSu2+U0H1f/wBS0m/6sZ48HpzMRa?=
 =?us-ascii?Q?wHuevJKPRTC8em+aQyBzTUVBwzuJ+RGpI927jwFV4eM1w4IW4sHXqDKFLTl3?=
 =?us-ascii?Q?62koP5w95DO9r26N5UNPnzAeBkNLa1W7k5zekdbvz2yEIheHnuyboWu68uBA?=
 =?us-ascii?Q?f6JZvUc61vSvK1dO1vQMhTqhN33uMAPE6q6E27Uze8B+goFRvHqchX6ctW5k?=
 =?us-ascii?Q?DhRPJPPf7eqKK5L9O3Nl3YVPqRmExbLGex21yEQghw+KXp3L6BHA0Kzh0boJ?=
 =?us-ascii?Q?XJM+u8Jz2gLmrUtuv1npgzVZpEHPK1iRQ4H2c3ZdiIXfaEDufAp+G4/K3dgj?=
 =?us-ascii?Q?IEzOa7apptTOKFfu7mvT2LGlJRCUpPDeTxFj5vAn2tdwLv0ovzVEgxz++7PN?=
 =?us-ascii?Q?hJBZVgmLXpPlyWuKcJ4rTfVASD7cqxEQqZB8dkr4jQUlPID6wHufqTGFv7A9?=
 =?us-ascii?Q?JZaGpTD1lphbavU377Ykz2+JpjW9W/gA8/XHgQL0ric/unWYmDzs08CFDOls?=
 =?us-ascii?Q?+WGftEdsNFv437QbV7879E7AARSecawBAB3pmpgkNKY3F9Ee6WcF5aBy/do7?=
 =?us-ascii?Q?F29jXruO7g3z8NMwnMNWwxkao4/heUiturXguYdN3tIT5KUtnNx9eJ1Y7GAu?=
 =?us-ascii?Q?2Y8cuFgdmXD9qNudTODx8IEb1aod4W3kyOgzMkYLYdng0fmiqCpJc/qo95WV?=
 =?us-ascii?Q?KikR1rv5EME0994Jdvgm5EJJntHSWND4+S8qveOhrTV7fofJoG6mswVRDgNr?=
 =?us-ascii?Q?GQXFYBplMbZaUMU7/TNnhUKbiYYe20RGwYQ/Pjtteh284kqupZ0IRZ3ISoYq?=
 =?us-ascii?Q?V6yRqQoq6MikG5aNQmUsJrRq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b094bcf-5b24-4088-6090-08d9456d7d51
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 19:44:40.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXFizZBkPJIQ52+76NW0Vt+RRunojSFTqc3ZSVp3DH3mwPzuH81UP14S/i5Q1++Vh8pvAOjgQZLuEuPa2IwZ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2481
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Jul 11, 2021 at 07:40:02PM +0530, Dwaipayan Ray wrote:
> Instead of "open coding" DEVICE_ATTR, use the corresponding
> helper macros DEVICE_ATTR_{RW,RO_WO} in amd64_edac.c
> 

I think you meant to write "RO,WO" rather than "RO_WO", correct?

Was this change inspired by a code-checking tool or script?

> Some function names needed to be changed to match the device
> conventions <foo>_show and <foo>_store, but the functionality
> itself is unchanged.
> 
> The devices using EDAC_DCT_ATTR_SHOW() are left unchanged.
> 
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
> 
> Changes in v2:
> - Revert back the device name changes which broke
>   the kernel. These were using the macro EDAC_DCT_ATTR_SHOW()
>   to construct the show methods based on device name.
>   Reported by Kernel test bot.
> 
>  drivers/edac/amd64_edac.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 

The $SUBJECT should say something like "EDAC/amd64" since the change is
wholly within amd64_edac.c. Using "driver:edac" makes it seem like this
patch affects multiple EDAC modules.

But otherwise it looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
