Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9E33B3A7D
	for <lists+linux-edac@lfdr.de>; Fri, 25 Jun 2021 03:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhFYBid (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Jun 2021 21:38:33 -0400
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:51141
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232906AbhFYBic (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 24 Jun 2021 21:38:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jE+x/n05/uGKw1+xvVIoILq2p4ZGJ+sm3vyESHwtY6ohGtT0OgpIXOCZ2TJuWQnN66TX4DxBZgeC1zwhmkzSc1OFNNpl3RU7qNhyT61YXOA1tLogqNo7FLdOwTZ9Mz+eAI2QIocQeX0HxGGN5drafvfwkFT5GTNA9WzlxoCLWwnTAjM/e/hBLoQy6lOfk7FRVOx9QmTWBX58xsmpIvQrcDXToa/Ads6HeVt4UyC+kOsOI1jDfbg+wGLY1lmfppDsJz5hmPrgvoITQHrzx7FqIVobSSUaCB0xc/9cEEODsloQKJb/NhXgk61zL/T1rHiTvYzLM15L866SMx4v3bBXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN/q4/hwVumUQgKpkGVkexT8ir5tnwaHD5N8TvzMIC4=;
 b=nIRqm7K4CfkqSGXc/uMqZ598rLnBcn9vnMa0/knQmO7JvpE/zUMJUI9G1lCASe8uWT1jHqV2d2vrVpLF3e21+0wMhpCA0XxwwEMxLsOWSYOJCpgni7zuetYW7Qt1z4rhDJLgCbD5XeWHwDMjln9zt+cE0T/Mho9kbO7KoDzodpnIquqN2NgW+tuKqwBq58a0kuImgQ+ngdUtAO/bo+Cm6p/9JqnHwkJ2Dt5RI1bSIgvXP2DdnMB30f74dj//Wv0Ghy2NKFwqogmzLRqMmrbf6QpWao1JVR2NEcKt+wVTMk9yeVqFYMg/XvNd5PmT0KKgjVmkYOP//YqHV0fDcYWibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN/q4/hwVumUQgKpkGVkexT8ir5tnwaHD5N8TvzMIC4=;
 b=d5y37fdEZul02d+Y2K7jgi2w3dtWxprDLvtaz/7WTY1RBIUJf5NxyV8HNemUJEYtKcwN9nP3ftYIUXmo9XHg1JriVhZqtL9V2pJ6qNi23ZgJpk5Qo2bVwftT6T+xHbnBp/kdolbqyL5eTgYqDkkWgTdMraLoI+j2+83hbZIA1ZI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 25 Jun
 2021 01:36:08 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c8f:eff7:df51:c837]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c8f:eff7:df51:c837%6]) with mapi id 15.20.4242.024; Fri, 25 Jun 2021
 01:36:08 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Youquan Song <youquan.song@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 0/2] x86/mce: Support extended MCA_ADDR address on SMCA systems
Date:   Thu, 24 Jun 2021 20:35:53 -0500
Message-Id: <20210625013553.231528-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: MN2PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:208:e8::25) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx50f7host.amd.com (165.204.184.1) by MN2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:208:e8::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 01:36:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 367ceb74-1891-4a4f-e7a2-08d937799b1d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2686BA00C59B9F72D08EDFF890069@SN6PR12MB2686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xS1byPO+lP43U8BcxWNvQbjzMiALLIv+TW24xA0Q6ZPvU83hbmq2CzXrFyylesosc+KOLN4ngu+ezj5cGDSdN3h7C/KUofMpXd9ipeuE1oGhcqbRyJYW9AK+FzFeMGGqbeTyb+orbXSMjg5qlRsXwQomdZc+xibQ4DwmsJcE1c9FUUqTARwFAqqzucEdW5ot0OCmS+t04AUNg53JC2w/Fro7hpFHctMm70X6rgwijz3t9HzPc38wfdWGzNuUsQCQl1l/eAGIyyGsng0GBk2Cb06pd/DQkW5kGL3Oc/YOMrTru8JDBwPBrYKg38R2YGsDicmvvjGwOVErFN/nGdUfSG3hMm4GCPXZXkPI8kZa74Y8HXWBr9q7zy7acS7Ji4fVLVrzzKuNlxmAm3v+QlE+MTJY2eVdMJ95IIqCoLUhCMkSTjL5gcxfmTWncgY0UyVhesEN0O/GgcbyTmTECh0gLdfSLiGsUGW6fEop+WlKuKaMGodTPigavn28/P0nZe2qnBlt8ho5QPzd19jOQnY1TXAXl34Z6A3eq02YTuIfgDMwAwqv2Dqza1tgoAUCHEpV6BJS3TKpyrIJDtNztPd7d70ei1PwwUGGbAA7EM059UbeN+BT9Q65p0PnYvZ6+eKIc+yIEhiF+fLiFzbRLtJ9pLEh/obgVKnJN2m/VvzXLNXlzAi9IiV1EHxnNylGmC+GeXyEd61kBKmWnV7o4is/OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(956004)(2616005)(26005)(8936002)(186003)(36756003)(6486002)(66946007)(66476007)(66556008)(478600001)(4326008)(5660300002)(16526019)(4744005)(54906003)(86362001)(2906002)(6666004)(316002)(7696005)(52116002)(8676002)(38100700002)(38350700002)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gB5NRpUTChfQ5Yf0D02EcU0wXL0lqEkDS/pz36LQM4BwM8+EqYs2omlqCy/r?=
 =?us-ascii?Q?Kd9ntNGVpeaGfa9FZ5GPpeZaJA6D1ykKZmihqs4Of6hez9N/AHWg65uP20fh?=
 =?us-ascii?Q?Fb+vVLAYK+GZBvGHCmoKCe8uzFeQ4J+oXZtw3YutEuKe4Br1g4/UknxdPv6O?=
 =?us-ascii?Q?9FjXxFe9OyOQTq+DAeQqgbPq3td6xmqazp+8xonkpl+B30/nuw/MpHgKyeF2?=
 =?us-ascii?Q?LXqZOIikY5A771be0Cq8RhpLUULPNf6ZwpLnnahixggffuCXMYC9ve+1KERx?=
 =?us-ascii?Q?OMdG0HDq6+Cmkhk7sXqP/skY7JkbjtF5D3P+aNoqNCatYjMvAwWP+RRBYjgT?=
 =?us-ascii?Q?ynHV86wPRD0fYg3gPop/1LEhbUNwetc1Y3EDux92CKhIxrAACLrH5om7sBAI?=
 =?us-ascii?Q?fwsJI3kn52yj6jTLsjJCTUmbcoEQP3HdVnet3R7isl7IxFF5Tih2CZvcFNrl?=
 =?us-ascii?Q?LrGBjUlHM5CSJ72BoUsWvGSsevgPH1p2fN8gYuftflD0C7BbZo4HUk5XEjsu?=
 =?us-ascii?Q?ZEA2BWKRcX1h5xbXO7XF2zrWHwpdv1WvpxHKp4nTup7iqw5Aw7M6GybyuqCt?=
 =?us-ascii?Q?Otsw4Bw3PZISWR7N5kOXFkY0x0DlkXaDOkZOO+sVk1Kao2Md00Rgby+QltlW?=
 =?us-ascii?Q?tGB3ddT0/71418h0MplLktFbeBqKSynd8VLxN5hp5iGvTs4EMh/TCsJswarz?=
 =?us-ascii?Q?fgw3rfvfI4eUE2EBVLQpJ5Org7Ch6b21BN8nFqpLfvVNQzOgEgIJ+oT7B5wh?=
 =?us-ascii?Q?5RbLXiUEI4mrihq1uoxr6lE34Y6tpuoqUQ7c1swGl92uMHDzriNfcEaGAF8k?=
 =?us-ascii?Q?1dB4vpGSgNbu1fGovXg4QJKEElqjX6xbVD3O890a60dDYdZiOwsrFq3+acUJ?=
 =?us-ascii?Q?a5N2TBA/Pkq8QO2b8VXx9e+ikjNyGlwMHvHoO2keB7kTNnqrdgjMa5qJ3LpQ?=
 =?us-ascii?Q?80L1GhKlAwETwykhQnwNBtzlowzbS7jxIDWq889TU+zdHRxKhpaKZbFBUFrB?=
 =?us-ascii?Q?MpidwoLJVOSbNkyWZK0LScaPUjawL6tjCitLWRKfLOaC+PIUmqJ0iME8TZil?=
 =?us-ascii?Q?mCmBzuAOcIVr4dXKTsEuaeGS+NKTR3d0A/bQoHpyS5ntgagHwcwhwnE9vuxx?=
 =?us-ascii?Q?ofEFbbL8kEDPE+hnB+IBAcI07FkBPQkKJeVGu6FgnFkDqWoVafdr2VUsYQwE?=
 =?us-ascii?Q?CdeAgEi6RyWnGOHqv+Bp9tj1ueX69Y60/+9cOS1d3b4GE3FWKOGSMg4dSZoH?=
 =?us-ascii?Q?K5kkDIYI37oWkS+AOXKRFPAjenWfgSvnhpCv4Dd/2Eh7V4DVht/IDzXNVczf?=
 =?us-ascii?Q?6ucgUmtpzirjjheYYdEqRwi6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367ceb74-1891-4a4f-e7a2-08d937799b1d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 01:36:08.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHlSHjw22XDlGVmxsOfCKPT7hIXNsVnxCFwtTBXJyVmGMdtoC35qJMNU2pD28TcP2Na8+8HC5PK6tGFq0FK8ZA==
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

 arch/x86/include/asm/mce.h         |  4 ++++
 arch/x86/kernel/cpu/mce/amd.c      | 35 ++++++++++++++++++++++--------
 arch/x86/kernel/cpu/mce/core.c     | 19 +++++-----------
 arch/x86/kernel/cpu/mce/internal.h | 14 ++++++++++++
 4 files changed, 49 insertions(+), 23 deletions(-)

-- 
2.17.1

