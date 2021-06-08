Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881583A0694
	for <lists+linux-edac@lfdr.de>; Wed,  9 Jun 2021 00:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFHWMd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Jun 2021 18:12:33 -0400
Received: from mail-dm6nam08on2057.outbound.protection.outlook.com ([40.107.102.57]:9280
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229526AbhFHWMc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Jun 2021 18:12:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7CCQPBKE62n0Vke9DRwVoMAN4ICq4H+BbunuXZ6zEQUirhKihomtIuWlGCNo0id/C36UtZiSPF6t35/6i30zrGo9w7G4ptU0lvkNE7RxpyDJm3v04f8yAjVmNdhF1K+69DKwSFJFUIRNHndX5QaGAmKJTKnTI6qKVtX+alVrmtEvXjWXRrLmjsaO4UV8CQ5tJ2hWPntl9gh3YBmbUn14M+ujyqF29ODnoH3pFWXvLWY3p1td01mUypgduKlSt54wUDP8qY7QfEu7ref4QeRnkHYO0QrugF/E5cDQTmRPQE9HNtkLZWxQViJxW51V2W3FPAbEVkqTqPEHSk0oy+9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvRyOA4wjRQZeGyO94S1WpIHG2WY5JTU056kOPWSE5E=;
 b=VVhvVJ2Vi8fJeLxgCfMcX8ET3eM9Ykx+njuQKxn56H4S3tfY4L5gxMjKc/EUM2LGdLMQV9G2HLV8A0Ver6Xb41BLgNvWK6hzaNJMskxGxQ/r59VHH8EFGBs4wIcUphZ42uM7TEWQSEepgsOkb5Byf8McJJIhiFyawhEyqzICDuGL+oJfWFXoDx1GuzYPwlERzzEuI5ZiuCVp0G5pU2euJhLCGnrWRFshlFHNOKplabpeWv/ZgNURO/YiBX0dE97exbzD41tzDcwWg0AXgNjabFSOtUIzWdIinf8vsPn68eitz5nTT70VNqFgcJfvBJQJM2sAJXj6KhS9DI/elq5ZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvRyOA4wjRQZeGyO94S1WpIHG2WY5JTU056kOPWSE5E=;
 b=SsmcJnTxrPW+VP/dNHvA6mpNrr/EI/WkFKALKcTzU5iFiPesvrGkw3eQn5nquvwIa9K7IWJA5MVBO3vHsB7IUffDz4k0Hc6/TEwyylH9YgHGvjPdwuEvDimGThDXgQoUaCf/ycgC2OhgHOArw5LP69Ih2MgQit7F3cXl+UYsp8c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 22:10:35 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::b50a:9f23:d6f4:408d]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::b50a:9f23:d6f4:408d%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 22:10:35 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Youquan Song <youquan.song@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 0/2] x86/mce: Support extended MCA_ADDR address on SMCA systems
Date:   Tue,  8 Jun 2021 17:10:10 -0500
Message-Id: <20210608221012.223696-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BN6PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:404:65::31) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx50f7host.amd.com (165.204.184.1) by BN6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:404:65::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Tue, 8 Jun 2021 22:10:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d73d2842-da64-4b3f-a645-08d92aca3d71
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB268687629C2D6A83655D399A90379@SN6PR12MB2686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdcQNAyznuBVJMsGwMiBTaneRw0X8QcvIYyao5gwcUzaQqSoT0r3UQZxtPZVCSKfiMD8hBoJqrmN2YWGdjKJhNQ+K27vPOS2QjhIGidr+0OjVBsKAYpa1R8it7Yjz0GlRUwN9apq80lBxtQKpESf5LDWvi1aivjRaj+p9R6aefI3UjJ65kksmyuJ5qF+Z05+Q3eE+veuMSKqpQMXXylT1J2vNzatXF7HBzOkLBWrdY2Krutu7QWZ7d6DLF+1wAV9lxBNLkqmgPLLuXgvWsk3enNp8ajAzRbSS2VaEAsS/UWABHg58zeg0L435J8SQI/xU5SuHxJAXFqqachzzCruUWcV0O058piSpyATcU4X4ARqTTnIdcEcV4aU6cSx8jIWlQ1Iw5BLhV++aPWRrovaJ4RrC5oQFF4MuqQuIs4YqeAraYiekL50urcCzSgP4pbsPqmUr+/9Nq5ZgJkHW67MHrVyXxq2d3bQrEw3G8JIl+QexvrqTfRxW2lAcqmD/q3an5sKO598kddqYemUVIbXD0QS7AJhAk9wIGp7CK3gmM/jhV7hwqQ1nHoBFqMWSw2J0RZEtrENKF/yMxfWvkSLAc8Hd6FS56Oiz81a/sxf30kzc4g7V+DQ1iOK2hTP8ldkh1L7YJC8XeFqCemNicxKRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39850400004)(396003)(376002)(366004)(956004)(2616005)(8676002)(4326008)(54906003)(316002)(8936002)(2906002)(66556008)(7416002)(4744005)(1076003)(478600001)(26005)(16526019)(186003)(66946007)(86362001)(6486002)(6666004)(36756003)(38100700002)(38350700002)(5660300002)(83380400001)(7696005)(52116002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XPyDGFxIOiHFVLyptf2MKde8ShP9GmdekL3WcZGXZ4yga4f98B4oCyxkSRmT?=
 =?us-ascii?Q?Sh8iuXkJ09lVeOW/DX3nogIAvF/+dCUr/UWf8mo3eIPgDj9y+TNEtljAcbIX?=
 =?us-ascii?Q?dUWh4DB5yfqfkGDNp/oauBj553hMmcg9gB2VRcnInHbUKeOnfXAjDJhGkegJ?=
 =?us-ascii?Q?+hsod5nh0NmXFpGr4lmGbf4EXWD07PSAwQPnw19lDF9xr7n8fDjVBpnQC+0V?=
 =?us-ascii?Q?IZPUEeyoFWibnnxqnjPKSjuDC+wqZWqCyzUTMG49YLHd6zOYpyA/JxeCLIwM?=
 =?us-ascii?Q?jpoMFuX6ihwdsZVhJvgC+ck6KF0hX2zwhFe1ztHkCj79K61pO16YRVenj1M9?=
 =?us-ascii?Q?DV1AwASmMnGg7MhLnILAC7rTzE5e3VADUF29pczRLc09szAvzfSvgLdpzhOx?=
 =?us-ascii?Q?4+sEjVujpETWIWcxwleF+69GNQvUfepZtvInrRdDZN6BzMhpOHHTC1SuV9eT?=
 =?us-ascii?Q?8yHzUDlTCvTTkJbYQT/8I0LwH5kkvcDnTHjFJT86dWGhP/8dwgE+nQbFlUGl?=
 =?us-ascii?Q?1/xnfqa3gZkeCIr8PWamEa8S7SPGA9+ZgFCdJDsQfaPxZ1Fp1UY5MsWogmWt?=
 =?us-ascii?Q?FJOgiQuyO7bUI3VA7+5xpOD7PZu8jJDoIGvV204U5J8sftLUUu6027F8PckP?=
 =?us-ascii?Q?qp5PnlcugvCtxZxYDduYCU5/7ybtCUdBIitcEFJcCqjPvIALH8IYQ4geZNdu?=
 =?us-ascii?Q?usnvOfE6t3DE3AHCJqJAqVxCyUxwVlxmogAKoAFZ36MA3DtY6mFLmltw3uD6?=
 =?us-ascii?Q?hC2xM0M73wPIkTqe6oEriYInVo2jf2uR5kiR3wWRk7f9P2uvqV6XJQzxtARy?=
 =?us-ascii?Q?0071Glv9D/3P4aDAaRFDVWugPa+WbmXkK5dUe10FgJRlGHWX4HyTTSMyUpI1?=
 =?us-ascii?Q?Z4DOTkXw/ysDHenrcQ4Kc/avSb2f1Mde5TPHKlzc7gm8aPdMFrn/QL7dwN5t?=
 =?us-ascii?Q?uBCQtjtTfR9ApNxc+YdRAInCAm1tgyxF95H2XBbe6vqj5UFbUHL9g3LoXIZq?=
 =?us-ascii?Q?yOoLrOcXoSt65Hv8mJMGuSVOeUk/7LyUkJmeKGPvuBAFiYD0DAPCJj6QOnC4?=
 =?us-ascii?Q?/yg+z5a4sOoSuGmlvZ375Gxac3mq131HJvjeM34L9csVJvYz4YzoFslkjSPj?=
 =?us-ascii?Q?2oBXLWJpCcX7SsHYZLydtn/j3H8MN9jxKU4aJyZr9jBoMGAxUmg9MFttmJW5?=
 =?us-ascii?Q?osB+0aTXQMIjAIFu8zkAd6NF26joDxPNvbSwff2RctHQEDE30NTNu2y0/55r?=
 =?us-ascii?Q?8Ais8EZS9ELWpx8MIACwSxRl3oQv+uOkaP3DHu4+WktF98qQa5lwuXb96yuC?=
 =?us-ascii?Q?jo2jLsX/xD8s7I4l6/lIxrgx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73d2842-da64-4b3f-a645-08d92aca3d71
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 22:10:35.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLbo1t5MwIMjeDlEB3lKsKTsvkcClXZgwGI7aAhzF2wb+NIf0MNb1smG54rjixmwlxduxSKPScRnDe4vH4lrqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series of patches adds support for extended physical address on newer
AMD processors such as AMD 'Milan'.

The first patch defines a separate helper function to extract
MCA_ADDR[ErrorAddr].

The second patch adds support for extended ErrorAddr bits in MCA_ADDR.

Smita Koralahalli (2):
  x86/mce: Define function to extract ErrorAddr from MCA_ADDR
  x86/mce: Add support for Extended Physical Address MCA changes

 arch/x86/include/asm/mce.h     |  4 ++++
 arch/x86/kernel/cpu/mce/amd.c  | 41 ++++++++++++++++++++++++++--------
 arch/x86/kernel/cpu/mce/core.c | 13 ++++-------
 3 files changed, 40 insertions(+), 18 deletions(-)

-- 
2.17.1

