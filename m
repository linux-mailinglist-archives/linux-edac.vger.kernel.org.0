Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D85F1D18D6
	for <lists+linux-edac@lfdr.de>; Wed, 13 May 2020 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgEMPMI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 May 2020 11:12:08 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:6101
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729179AbgEMPMH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 13 May 2020 11:12:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqbL2q8qnt6dGux2NM2m3y2nYaPNCh7HUOQ6dKc2sL+vnavxI4uKZFEy7WjdrXVGMnThV979zjo2vdPdSFlAAJ5iXDwBJgin7ArJfWFq2L5FyyvgDhyX7ua5E3rwO+RAs3wBdkRGNJ0FBE32mQOvZysLibyTvZ864lOLNTEc9bNhEd0hmFowVvaIBNpKiavb6AkojcoKsqoiyNQv6jlulV5fAaO8EI9r6sekxxhlXC31Xcz6jz/0Fp9QNuQUZIdeyD+KLwgP/G+2UyW/dGDElB24kYgTdObUHw7xfq10RKnzN4HM0/V7y84Y7R6IEB7XHWA42ufh9YcvHujyWKvvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijmaeuqHn2WB4kcv0IcdF+tkYjSNIOYfcTHXHP+oHmE=;
 b=ioOA7xS9MYSOBAryoBzcVGbQTJTNfj/p6utwWP+s92AorLnFTuDiIOK3VSPZ19ToCpOFJCb0wNLVr1Ez9AamoWqGl1pfFcZEJ2oVLublGxrSOXM/SuZxEVEtZammJJJli5BFT4rCCsYR6vANWHV7vp39BZMMVhP6FV3YioPr5H17/zgMA3FWB/lN9Hclk/GWOs8V/e2A9NoC+LrsrWD2wWOYk4TrohanA4UYBaaDiMy5C9VxMhZhLclxbS+mpoKMb8XPsxIa2l7ZL0XHnnX4To86hd5wLWoQkJdflNqXspvC4u2oU/c1vlel4EFMR26Jl0N3rYdHwrtBeXTLbXucTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijmaeuqHn2WB4kcv0IcdF+tkYjSNIOYfcTHXHP+oHmE=;
 b=KMWje8sL1pdyJ+rS7c9ZcKZ6nKajw5FUwPmnP82bn2nK2oP6cvRPf6LSs58/XZu+KjswGmhigZa0vl7dLXBEOQK6Setb/P7hTZ4RM7lx4w3PytZAm3LvTce4jVW5JDx6K34c5Zmd3F1x/og/SFXEftEXfEARLLyiVyaDRLkMheE=
Authentication-Results: ispras.ru; dkim=none (message not signed)
 header.d=none;ispras.ru; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1218.namprd12.prod.outlook.com (2603:10b6:404:1b::7)
 by BN6PR12MB1393.namprd12.prod.outlook.com (2603:10b6:404:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 15:11:30 +0000
Received: from BN6PR12MB1218.namprd12.prod.outlook.com
 ([fe80::b021:d7f2:52aa:1fc]) by BN6PR12MB1218.namprd12.prod.outlook.com
 ([fe80::b021:d7f2:52aa:1fc%8]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 15:11:30 +0000
Date:   Wed, 13 May 2020 10:11:27 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Brian Woods <brian.woods@amd.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH 3/3] EDAC/amd64: Add AMD family 17h model 60h PCI IDs
Message-ID: <20200513151127.GB3283032@yaz-nikka.amd.com>
References: <20200510204842.2603-1-amonakov@ispras.ru>
 <20200510204842.2603-4-amonakov@ispras.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510204842.2603-4-amonakov@ispras.ru>
X-ClientProxiedBy: SN2PR01CA0027.prod.exchangelabs.com (2603:10b6:804:2::37)
 To BN6PR12MB1218.namprd12.prod.outlook.com (2603:10b6:404:1b::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.1) by SN2PR01CA0027.prod.exchangelabs.com (2603:10b6:804:2::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.31 via Frontend Transport; Wed, 13 May 2020 15:11:29 +0000
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d508331-16a7-4055-7fa3-08d7f74fea32
X-MS-TrafficTypeDiagnostic: BN6PR12MB1393:|BN6PR12MB1393:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1393D1B3CCE2DACD0F2151D9F8BF0@BN6PR12MB1393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9bI+tLppKc4vbRETdQPPFyWkj7Q3fIYFon4WIBsLvuJPRHXHqgL/AYLlza8QC+ufeQtPyTM34QCF9wHK2N4rCD+2j4lzSFy5A7OZ8wg6aQ75k+p4ITaWC/KJvMJ0pELACrcXpsSx98pe/MdvP0xXaFsgw7Z0N7+IKiVfbpoI3qv8gDHNMWS3ZYgzo9dlS7+Wrkdr+YY3Vw9RLglApHFfwr4vjoYdLuxvGkEnoUn4+Egnd5d2gcaxkE638dst/n35FXgh0krjD0ACj+Ywq0jI3t9c2ZgIXNznyja2YkRNV1/wrWP1v1Jp9iurz/WKsFrnxJnU3ubJJ0czsjHbFN0IH2aQMgDvdTocwsgv7cZP8MelRp60xppiXzIW9RvZvxB91Vv2hj6ldKZYbbFxORiI56hMjTJqRgUCKNfYUe6TE3/Sv3IExyBwEmBs8lQ8Kg2+J/dBoZI9ZJhHQ+ltC+dab/xOiobBm4ZLSTvm7NNmA2cPKDCQJFcheC/Ym+EFKDPahg+JoJKobcnTKvx/Sv7DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR12MB1218.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(33430700001)(52116002)(66556008)(33656002)(44832011)(8676002)(5660300002)(16526019)(26005)(2906002)(4744005)(186003)(55016002)(1076003)(7696005)(86362001)(478600001)(66946007)(66476007)(8936002)(4326008)(33440700001)(316002)(6916009)(7416002)(54906003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TNWZPOpkyOVziuRntyPVama/bPj4yhsRQfe1iWMuQKy2N2oecNibXf5SOPRx3muxA+22KGqnX4vaZMLowadtdIb0TJdZqAXGtYIgBjXQG0QW06La90Dw2ZFB/OrAJ/elWFN9W/jAIloAAy1fs4lNdFgjHb0SLI/zQn+C1P2pAQQIPzd37gbMccPWZBV+oK/FaoGe8Z8hyZ4MkuDwuwwma5mRSCZcB5B2JQOk9ZpT1eTV/spHKD+x4hJ4WcX4lhYRUFPf4kJ4cJnNstBtGWlx52XpaBXqbRFZ5wFVRvVjrXlocg1WzY3U6Tm1VgrPwz0Mpbl7L9YOLT3lHwKiKWnLHT30TVLbkcKduJJIP41vVdTyUmqHHUdGBaRjVvhdgwtsXI2VH1471iYJv7N3ytMNwD+s1DWGhrzlmfRvgEqhCrEr8cG1Dja2KJ0vuevAagf2unvje5T7MuU2TaoS2GUCfnPNjdDH8GiQ2upVAu76XZo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d508331-16a7-4055-7fa3-08d7f74fea32
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 15:11:30.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUrsAZL+j23H+WjpCv7EyMtng+QfTXB2BqsFfn6OiCMDVl5uNbLvNR5awjyOIOtaxgipLiJaJITvtMDNcLcOpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1393
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, May 10, 2020 at 04:48:42PM -0400, Alexander Monakov wrote:
> Add support for AMD Renoir (4000-series Ryzen CPUs).
> 
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: Brian Woods <brian.woods@amd.com>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-edac@vger.kernel.org

Acked-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
