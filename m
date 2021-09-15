Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E4A40D022
	for <lists+linux-edac@lfdr.de>; Thu, 16 Sep 2021 01:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhIOX3h (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Sep 2021 19:29:37 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:50689
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229769AbhIOX3g (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Sep 2021 19:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn6Pm1fGVb4iQfqKQbq2iUUDIuzNEVNeSDTijGOdG803zJN1OrMOErpoTi+xFW9rsqHccU7C4p2+dlHbQlfS2/F0l3eN0Y/B+GlDOLc3bErY7E4ZSwP4OVwSDknTpK2AtYvxEemvkXPR/qNjbVNemktLx23Vbiu+YHpzJO38VRQ0jeyzVjmN9bRcze8tdQ6LW73Y5+457YaWSW7IkcaUkwHfbrfIuQQvIvyhCKBPCBokBc3krBrFVnYTiPNCiFlsrGgdM1OCztM3hRPFxZ9jA2x9apRfzKVRO/jUSIQD5iksr/Nj+8+dhlRAaMcxSWEcrDEiChwTa2llXs8fvKuBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0rXlzGowEPZ+toeeCix4t/V4B7IhmAzjYJ2NGiqGWy0=;
 b=H8JwWhwhmPnlE2DmLfor++BhRuA1tE5X6MI+EJjl+Pn39WcQNyv7NfG3kqgVG1WXEz9UFhDv3dblzUdVmD3JPZ2cCPZ/xDsvoKUMZYDn0BqYmtF8dJqKwia3+U9puNjq0WIFBkpdw6x/v/woGvxiYS+lCftxmQF9YBFd1/NvxQXB9bGyoRAhKuXEcYWwQLNXhbBVDY0UVAilr2XQk7LcVxvpWDUkAnoi+QIBVcqOu0wHEmpXqAJEfkT4MCQyAL7eE4kvlF3Ue3oK8grSojJ227YVmtZr8fSkoBXJF5upCa1stXXVbsOXHQVArzCt0iDy/jf4fKI1QNpXmCgjZTvytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rXlzGowEPZ+toeeCix4t/V4B7IhmAzjYJ2NGiqGWy0=;
 b=d91oT0qMhO+EO40OIN2J1HqpMaaZgSG+YQQd5+PGdze3EtTH+3M3lJ5S4zyah4ZQU4D+qDs/RPG0Iuge5zeHrCVnMWnmavfIUU8X2vYixi4Nc41hJDDD4wx6bBD3/Bs0DZcLfGQE7bWh3wyKOtzS3sASCaykj14FSQjuR9Iqitw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 23:28:15 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c%7]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 23:28:15 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        yazen.ghannam@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 0/5] x86/mce: Handle error simulation failures in mce-inject module
Date:   Wed, 15 Sep 2021 18:27:34 -0500
Message-Id: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:408:e8::20) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
Received: from ethanolx50f7host.amd.com (165.204.184.1) by BN0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:e8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 23:28:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 094285d3-9e38-418d-2990-08d978a07d6e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45129C21B8FEECAB50D62CE390DB9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwaDZB+lfNnAxGIVpj2VltsOisnkBFmT90WMEXsTtieXyF3K5s+t+RQcaM0zkKWddVv+1Yx4IGhZObF8v7wCVJYlkOV7HG7mV1/9n2sZH/tB7et2Se1tIqdopi2rOJ0IeLFLmMq8ufGpPQ3Et8FMaGqDYD58uly4y3zUE1ApdT50C2yamUodwwjN8jB2+GKOSKjI/yEIEX/E7XBA83txWD1g2KuCcS2mnn8G+YhwxR4psFNtR/j1P5YAaMv2JAQbtU5xkT0xy/APz2Yk9YUIt9BI+9j6DfK8JS4t6wryYZaN53/h0VEuEL0P45+34+UsRKhkwU64IeasGub/BjAncryFz8NsGBgBM842dEU+b7JER4mbzeYN/3dFpgjtN3XDThWdCnnFGEBVydUqen+0OTCuzOu8xomybdtdBHwVT5klqpaBd4uQACLHTarYHC1+3dI0gV25iHrikiXeRzm9QWnS7x2W9NRQnmqecYPEyykC8AVblBBsuEOvDj03hCmhBQnJdLSvZHIWGyd2e2B0usBGrlD7nEAnyYgfg8knAVYkrRe6sjpWDLHf8jFmraIh3Y9PATB8OxoAffbTywcMqxBL7/WH22zy35fQ/pszbLWO8wn8YB0h4r/gDqXc/d3Vk9e1ZrTIcUmBeNKAXX7ggrIepd+Yd1En8kRcQOzv9bXXqrdLod0QbYBVrdZdna3h5HnIlnjR+kX8RSV848/s1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(86362001)(956004)(2616005)(66946007)(4326008)(66476007)(83380400001)(26005)(478600001)(8676002)(2906002)(186003)(1076003)(7696005)(52116002)(36756003)(5660300002)(54906003)(38100700002)(316002)(8936002)(38350700002)(6666004)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C0uTmGwegp7lUNfVC31rIdenzPEjHwErZnRk9UWzFXUP0NvLdysFwEia6ayK?=
 =?us-ascii?Q?0VIOr0ygnnNTjuYyo8rI9rDUAx3bHK5wIdJHT78w2pWDzqgbdX4q8Z/Pg+z+?=
 =?us-ascii?Q?nyE3hdKMTCKGbzCObD+8LV74jUfji3kWKG+u8QJVSBVLXyllRnVkNuukecV9?=
 =?us-ascii?Q?ivL6yNKAqZFYpdmdNe6N0Lw+L3ezDQ7/PW8eAE6V8FQ7dobqeQv5U7Jfw+zJ?=
 =?us-ascii?Q?60IqoKR1yrr6iV/UwqTkDe6g4M7hV3fPxMuogisiwOmDrd//OCcaptWfm9K6?=
 =?us-ascii?Q?Rfun+HZg3L9O81b+aW4ebkNew9KVgPPxwioRbKPQGnuyI1GvNYtf8rdoK47r?=
 =?us-ascii?Q?mySFTMbNCtqp7cnjJmda6YyEo4CxKHJGVAgEVgE88sW4WQ1imtVyzUV3tGdN?=
 =?us-ascii?Q?WYnP0UKg0ii60ccrmqq2vzHatV/TbUMNkHl9w5xkLrreW3Gk/BSnDrUHHE/z?=
 =?us-ascii?Q?lx2Gbtjx6HuYuu9UCv8ON6UyguL0FArMwXUKXT5Pp1hIaG8+grXbOhQIbx8o?=
 =?us-ascii?Q?l0LOOtZ8KwvPrY7q7LgXS4D4BpwNkGjtDqW4vVpJw+DGgvLQXLI5iLUemrjL?=
 =?us-ascii?Q?PxosQZVCMHnD4x4whTPevCBK8p7FQkJkll1w3DL0rFE7d7orIFvtyARmmWdN?=
 =?us-ascii?Q?C3z0M136KIbgHigYtIHr+363nZRjEW8+KNRCi+4D9mtn0ZPzLMmvU6hH1Tsl?=
 =?us-ascii?Q?YXKy1/5zCZQzLFpjwTXn3L+mxLHYNNy0AYaKYOfM9cVdldEtaQ5JCKl7PRdt?=
 =?us-ascii?Q?hnhCVHExV3aoGGxDPGBIDjXpMMUeCkVh2DVGG/nXLHopAqEiqA9xvwq4pkBu?=
 =?us-ascii?Q?qdZ271v6BUUESQYY03s6IHxh8H39WmoBJqyHXYOwB+56aq43j9BmxSUvxhzt?=
 =?us-ascii?Q?nUgAbUwfwhFfnIwOYU7rtw62tvB4g8++yXqueGMN6PmCzoUrzY93UJ58EB0g?=
 =?us-ascii?Q?lj4wWvDmUNc6RHYHAKr1HUTxIoAut31DhpcbVx/MSkoXRvAWEurAeSAQXWqK?=
 =?us-ascii?Q?UtCJKNWtuyXOMAxeDQytvXAPL1M9riuMlLt3ZXifJqITUDdJhmagoNtYFk7j?=
 =?us-ascii?Q?VRdQG9rfAUWyHKwHVSvrpDRvna9CnymQ/UJdxYa3ILyOSYvjDTpuJwmx7kaF?=
 =?us-ascii?Q?jqBF3qWsgDibWyNqCT0a9ZJSbxR95V5pdMIOBE3qhz2I/v5mEu+Ahd4g2x3T?=
 =?us-ascii?Q?m59EG8XWuqFhXXcRsZbi/UQtUkFMwzXXS5oIk8u9H7/ND/tt0brrARXHKpfU?=
 =?us-ascii?Q?5rS8I26eY2pR9TzVxKvWcpgHyxPAPo0GSTkcvC41l0xeMHRJdI6VQImMZWI1?=
 =?us-ascii?Q?f9PSxtZfc3EhUjIgltHRyIhW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094285d3-9e38-418d-2990-08d978a07d6e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 23:28:15.0454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9+P+1urjywTKtPoAVe0zxNQ5eXMqOBCN1hKWu0RAMp1f6GgNswVwPus/TH6IL+7u1XQGXrsxJL5ay9VhPduCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series of patches handles the scenarios where error simulation
fails silently on mce-inject module. It also cleans up the code by
replacing MCx_{STATUS, ADDR, MISC} macros with msr_ops and finally returns
error code to userspace on failures injecting the module.

Error simulation fails if the bank is unpopulated (MCA_IPID register reads
zero) or if the platform enforces write ignored behavior on status
registers.

The first patch checks for an unpopulated bank by reading the value out
from MCA_IPID register and the fourth patch checks for writes ignored from
MCA_STATUS and MCA_DESTAT.

The second patch sets valid bit before doing error injection.

The third patch does some cleanup by replacing MCx_{STATUS, ADDR, MISC}
macros with msr_ops.

The final patch returns error code to userspace from mce-inject module.

Smita Koralahalli (5):
  x86/mce/inject: Check if a bank is unpopulated before error simulation
  x86/mce/inject: Set the valid bit in MCA_STATUS before error injection
  x86/mce: Use msr_ops in prepare_msrs()
  x86/mce/inject: Check for writes ignored in status registers
  x86/mce/mce-inject: Return error code to userspace from mce-inject
    module

 arch/x86/kernel/cpu/mce/core.c   |  1 +
 arch/x86/kernel/cpu/mce/inject.c | 80 ++++++++++++++++++++++++--------
 2 files changed, 62 insertions(+), 19 deletions(-)

-- 
2.17.1

