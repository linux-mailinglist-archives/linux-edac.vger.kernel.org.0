Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10553B67AA
	for <lists+linux-edac@lfdr.de>; Mon, 28 Jun 2021 19:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhF1RaZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Jun 2021 13:30:25 -0400
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:65408
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234435AbhF1RaW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 28 Jun 2021 13:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSlCGLziByW/zsxnlt1I6txZx+3ZL7MoFecxnabVuDbt/UlGOS7A7k5ZG60k3vSLou1ltM8E3XIhh+GMKVimxeELjsuRqVPhWrh74Y6+1sn5txNuOSvs/bePdtiXJJKqyQK5oG9AKZ9sprsJiGpOhD6BpKz8GXiFFUuPzUTE0eyaIGimv/v60HEcFe0MAnbf+iCjkf38BuGKlOSJbnTmTygjBtMUiE5EYDSSiSdxTId+YxsgTJJipZj9xPEDEJ7DyTccS/vWVp5bjMUQ2GkmD6aYCS1PpXnrKSeo0VTVA+j3GMZZOlZyvM0b7B2p6/qOGP4QODZk7HMd/jqMvzW51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN2lGbK1c+9jV0EGp9ufCPjR5ixUec/77Ez1Z8S+6kc=;
 b=PCtpcc49RCUCMvztTNkTVEDMycKbKdBBeFOcWtAFTlH1/tCcTONXYzeJgR4hXcqPDujLp1q818mlpESwpo0hSTG/eqdSFUOSiCEXjlw5DsDmAyWIysiKMXTrZhTvj5ZdL1aKnBeTCJ9qfbKoyOekwCBD9pCNgoDz7z66SMHs0/HPMCTnhj9kpR6QdH7pNUh9z/Fe9H7Pyu3qTrAKcZcSigwlyn3TYmjkenFkOtsjw3gSWyFto6zDTqe7+XMPuFO6yxVc3hVWCu3cPYN4bH9lHP/eQJXMZVWzteUO+uZECmDEY9iCN1DFb+qc7C9T1vkyCDo9Ggg76ot9jWVfc9pAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN2lGbK1c+9jV0EGp9ufCPjR5ixUec/77Ez1Z8S+6kc=;
 b=nr1YcdeTKD0a/SIKeas0u3sByRR1TDD1XkjdMaL1N/dGndAbPBnM5wtknW0vTo1dw3QT8I3/DvI3dptnCl8Cr8CimYod2UrbKQfp71RJSMAkPkMQYDm10VMRRr0hdlI1s/mk9M5UDV2E5p6y0u+moLFqQ94LuuRzCRe9SL9+n5Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN6PR12MB2829.namprd12.prod.outlook.com (2603:10b6:805:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.26; Mon, 28 Jun
 2021 17:27:55 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c5e4:8836:cd7c:cda]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c5e4:8836:cd7c:cda%6]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 17:27:55 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Richter <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>, yazen.ghannam@amd.com,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH] EDAC/mce_amd: Do not load edac_mce_amd module on guests
Date:   Mon, 28 Jun 2021 12:27:40 -0500
Message-Id: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx50f7host.amd.com (165.204.184.1) by MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Mon, 28 Jun 2021 17:27:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e89eb8a-e404-4db3-4310-08d93a5a10a0
X-MS-TrafficTypeDiagnostic: SN6PR12MB2829:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28293079F70FD97C11205AC390039@SN6PR12MB2829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTZ13fSJ1sHM0MKq1K/qK3TvQyfhw6a9VwHFQ9o5AkQXagHil576C7RRJZDNfnXOakYhqXS4YmSzhdDVbSk2SMYI3frywJGQHwW9BW/m+3fy6DNP16Ntaj5Y9QIxZc0jvDYciBqxIPfMie3hlbg9YbYgANZeT4ACQYSo50E+s3564GsllooxqOUbU/EXR60q6vk7T+oJP0GtyWQWu8vjMf/fuFJbAI//5oh5sKjlhsIIajvkQ4X6vGr9tHLoWYzdhkfxJEgEqplxfWe8tXuILDOrwACyQW8blL4vHt21Vd4B2bwvJE2OA8QHbn5SWGoqzpxD9IS48tVKRJ/lek84f4DJzR6HTRFxjI7kkzJIbNwXgPWi7OFMVCpuAZZCrn7fMJKi2rAjoLwPYD8FSFili9WEqXyl3oSPsVpJ02HgMmUaP7GRijvMMcbOwXPkztN+rpBDdXSe86GFz2WT12GjCVg2A/uOVGt/EMH65WTFzXlM/5DkHEpVDVF7vbTqJy4vKkM0sLGvkFy09S5aHt5jP/TmmjR2rSRAL1Ed/3eF2No4qgfPhywNCxbfZa9DDhqVpiW57EAuHSBUOXEYSFCoJsASszT3GgCYyu/GgPqmc3/y4K0RIHS1Bu24CuA07BKlfwW38/FEyP6FhYeL5qbiRGWH5v++VAn08kSoanpobrybq/OCq0g/0fxWZOE3RmoDkxxLjz1Rm+YaCYo/8peT+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(36756003)(86362001)(38350700002)(38100700002)(5660300002)(16526019)(6486002)(2906002)(2616005)(6666004)(54906003)(26005)(4326008)(8936002)(956004)(66476007)(66556008)(66946007)(4744005)(52116002)(478600001)(186003)(316002)(1076003)(8676002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7NTTUVd3k+YsbYi5iB6odkpe1gDlvRXdN8tfVGjn8jM1KB/3Kb31uZnupWx?=
 =?us-ascii?Q?hffoFwdQIQfNQT+M+hS0mE9KgouDkEJ34BbdfJyyxb86IT3hdbDVa38tNijP?=
 =?us-ascii?Q?w7SonoUd0+2UI/gMRU0olvuZZDCaonYxe6yw8aq/3uSsGCWIGFkxrkUc7swJ?=
 =?us-ascii?Q?10C07u90Ob5EQV+Bmsr/uY1QSOHeYd8ZqC8evPDqQWiIUGCzq6UuzTC5pqFj?=
 =?us-ascii?Q?Syp3fow+/qR25EqgUk6zf9vGZ+ZS1V46WXy/4lA1tfVgDZPw+45n5qU58lCc?=
 =?us-ascii?Q?R97cXgbFixjbQsNYUTGJkl87IYTmbVlPt4rDxHSoQk3D/aCMxO/60mTA2VWt?=
 =?us-ascii?Q?MwfQ+uzfmu6BMHQYUA0lS6+IFFyZprGgET1Lury1BM59MO6zmBj+OWl/1UFT?=
 =?us-ascii?Q?Z4Alxv+hT8f04DTwoZakOndVYqoCF3Vs9JxoMJaW4gaRcb6AeQssZQ+OzbRv?=
 =?us-ascii?Q?ydzBz/3RpjgggLvMNo9zqp/M8hLo3r8/xh+KIaH7dG0ljj1bPs/Evb/2TEut?=
 =?us-ascii?Q?JpzJPaB3ZaPcT/arERa5JQ5iqK92zsTIgqKe8a/+pSZwg5eKUMrdLxwNilg5?=
 =?us-ascii?Q?z6sEVtiRRxZBFwc1lDu9I1c9AJIaB++OlNeV0IrdLjECxby1sH3EtsZJgDMd?=
 =?us-ascii?Q?553w4/Uk4kXbrX7XX/QhPjgfFSNLZscQZFWgzH6GHgTuUTW05GQdZuB85dTv?=
 =?us-ascii?Q?Hcu/h78mGWrRYnSt5Fjo9nmGh2qhHuod+Q7iihWvVB1Fug0s/kDL19xlogCL?=
 =?us-ascii?Q?ZGTukx8GvJ150WgBeCQFWfI3qcIA+q6r0U1BvPerAY79+u6FwACwrlUOSeyP?=
 =?us-ascii?Q?/638Q+L5pAN4a0gE/pby8jNX6ko2OI2ic2XoyJShVH1l060BxtYP+95Zc5Y7?=
 =?us-ascii?Q?txNrsy2w9LJyKRjWGI3iySGZ9RJAOKzP0PvF0TP79JhIhyrpHSk+yZEnS+No?=
 =?us-ascii?Q?R4HR8OCNR9WzYbHCLDI0HVfiUej/z5owmhsaTV+o+EU2Rg0tL5NP9N8Fnrls?=
 =?us-ascii?Q?8GPJlc62hfSxQoA1eU6s423lpCoDBOpuoqMrd7aITMsrQLAmM+kDrSc+vfeW?=
 =?us-ascii?Q?HdYiH7P6w1sd5SJLNWBARRnfHySAd69WkZQu8oASudbJJJS0nwSaApNwEMjZ?=
 =?us-ascii?Q?Xv6dLJVlujG1rSHWf+rVb4CBhQHnGpxafnRHTeCFLmDW7MRuf7T7ln8sdOWA?=
 =?us-ascii?Q?I/2+e9chufjJJY+LCwneFbFAoUc7RGVOohMA+oAjqRxGyfikdRj5d3vU67z2?=
 =?us-ascii?Q?thfA8lReXj9n9IC1C65i35dAjiwob1d7XuIvCEoRsu/plL2GBBnn89ZAdIfn?=
 =?us-ascii?Q?0PECCKi+tEmCZOy//YYJFput?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e89eb8a-e404-4db3-4310-08d93a5a10a0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 17:27:55.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNzvQI9IS5iOmky2aBcKfrcaLBcN9DCpSr10/blxgp33d7u9LtJlgpcVK/B+6xM+5oHUA1jbhWm90X/eDEirOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hypervisors may not expose SMCA feature to the guest.

Check for X86_FEATURE_HYPERVISOR on entry in mce_amd_init() and return
-ENODEV if set.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/edac/mce_amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 5dd905a3f30c..1a1629166aa3 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1176,6 +1176,9 @@ static int __init mce_amd_init(void)
 	    c->x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;
 
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return -ENODEV;
+
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		xec_mask = 0x3f;
 		goto out;
-- 
2.17.1

