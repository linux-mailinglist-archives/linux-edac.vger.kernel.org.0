Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A0E376A55
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhEGTDU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:20 -0400
Received: from mail-eopbgr770081.outbound.protection.outlook.com ([40.107.77.81]:44439
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229813AbhEGTDN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXDCAMzkamYdNcxaikuPynpLOMdXenR6tSXEn+qYJfNuRuEvL3ih2/DmUcljU3ns3vPNZsy5ffG4laJX8TSS6aDW93ffcmeNrnDtYNyNaxyapE235VppKzk0AyLb8w2GAV4bea0KdYY6BixwZRtVfvO/3vJ3cAn3bbNsJjcJEs/4cqfoB7OL3EPeJgoMA9L6HkMZt5zuqIb15W3T7Kv6HSXR0eaqFWCOXwxdtkE5org8HbnMsSFMb5BydY5s0aUiEZjLRs7lECBV84pMPXcjA3GTpVGLeBpcWlZfPDICwnY5kAn2ILhe8PWpFaU645rRTo6VZPw1vNOkaFRxFI0SQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9ZX0wqyJQAH3hsg7EtYQflBXgwr+eJoDbv9+8PS6DA=;
 b=DE606kkrSf0IhEF6hGwVskLtH16opHqUN3uWJwXdkVjcy1Lft/f3/3mPSPwEZOhG6oWGJSVjCO22m8g81kbOkTY4WwSaM9hd7Doys6xcWcrQ033rbJXYy7yTvKE/CkipuXT84r7SohB5Ypfv1b5/KVZyWZWxZA26HN32Z3ufC5XSPJeEppXJtwrAxBMfxPwZwUaoFWElKlKa/o8lDGuL8aME62xCbT8iqtTqw56OP1/w/eSrgkQc2ch3uIZaoEdpWLYKme9AA5ZyuFJKy+gHlwiTQfJtk7vHZx4MAxNwQ9u1osNpr8sJzEw0I9A9cfKkxN+aAi9JyCRxld9woXUaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9ZX0wqyJQAH3hsg7EtYQflBXgwr+eJoDbv9+8PS6DA=;
 b=zWjEz6KSkwh0eqslcBhsqSWytX20PHfVgJTOjTa/LanRrFB14CPQDmhjIODKhWIvwf5BIv9SNYUn34Ut9FZm3l+Zs1j/U1NYc3pPp+6CSOIiADOwF0LkG1etHkGES1BiZxGpEStpRxsc1lNbVIYElXXo+pUJM6wGx17QgA8yLLA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:06 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:06 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 13/25] x86/MCE/AMD: Skip denormalization if no interleaving
Date:   Fri,  7 May 2021 15:01:28 -0400
Message-Id: <20210507190140.18854-14-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:404:8e::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 344fefac-a690-4291-2816-08d9118a9b79
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB16206BCF940BA90B3500DE46F8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDxucoFDv312/VbR1HmAWiTNqXqhVxRci/q9VojUGFzppNzLwq+GVmFUztQH3sFL4wGupAn8Keuilfwr1bJaSfwDLDdmjtiY2QGBwwxdqiE3SQ4QboFYK8UOtCIy1dm36/u7caDqbOaBiVE69dbloBMWAHs77vUD7fzHWCtmlRXH7EVkX5Ku0XhQYml6lafHxgr284tONmrCS4gYYRjQ6+KmpeTWXv7S2h0wqz1OKZcFwweLsrHe6aNLd+uGwCFBKiqTsUTy6GBgrTyJ19YjHnQGBwUFuvTaYg+Kh3gTkKyHbJdcOqbRGpejFIM1EhAhVkLSzY0HM9uI57MzEYE/muaaVnN+UVTXY3luzAB4tNNQH9ion21VRN8hkC5FoT97746BqmsHOT+WTNe47YaTFANW/wmSH0r634t9ZsOPJjBxRs/+9liPQizxxY4U3yj6DeZ/NAJx20RQ6xCPYJSliV1zq3lhhumjFTWsWlOcU53Ud2ka1MoGaWOLf9FtQPQS6/gmV3eBrhFXPnhWl+UuTWuVb99B78J2WKfpUX2/zfJtx/kOUIo0/+GEV8QVimVX5krTNDypjL1HCBqiZ2eOGX0sGaK+6nBixouqqf5HcEwW9uupb4fIq7+v/BvxqhANp+oX8NqC8WtMvpB231lzCP1DHPobgiofUinB7AwF8Ic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KjRMfZ6hickrN0xikyH9xs6Kfh8PWatQ63nxez22icC0j5/Mqh62CvF/aD6n?=
 =?us-ascii?Q?wIkydTHkFHtRd3wlm5YeFBvhMruC1GH3N0mW+Fxz+hToaN55f8bk4rp11gWh?=
 =?us-ascii?Q?hXyVvxk1O5Ci0lepaONZVpS1wkZ2M2+Ms5VgIK/AgXXGQAsAFAhtvWMvQ0uq?=
 =?us-ascii?Q?j5inQVcFBQQlQDiD4+Iz/Uq4x5amhh0Tt2//iXgzNGY9rDCb8B1kHFdKosb+?=
 =?us-ascii?Q?wWtH+IEveOAYodL/jLCldefXfJWydz+auD2szCDsmjaDokSdaT+vAoCnifzn?=
 =?us-ascii?Q?QoFjxDtpfAFFM8Q1hhh3qpdfHGXqc8ieZa07HJe7vr5hB6VYq/lZEqu2MYif?=
 =?us-ascii?Q?SlFm1zoPKLYJ9TUnGZ4aUNfIkqIWNVJLA9xZltN2jxC+IpKfzMxoTcY5yhY+?=
 =?us-ascii?Q?nh/zoe4seG+mwct0xKJ106h7rNzUmr9K/5ozsY7LvSmGAwj+/mhTX8D892MW?=
 =?us-ascii?Q?vBilZNDmxh5jvmfBzterFgRIge8gDJn0xV11gSqGGd4Np8iH1ZZyGj5unnXQ?=
 =?us-ascii?Q?H+z2vLib3P64HG7eBEzcGKcweKsfeP1A018/SHtbyLiuKJ7Uom5Ev3I0mwUz?=
 =?us-ascii?Q?K9W7o3XHQ/GnC2NxmfWgSPiTJL/XJZRmoIvvOMwQbyHWHuuill4o9PYIJdGX?=
 =?us-ascii?Q?ibmbgYe3zASCtcqNUKTTsjRbnKruEFtOyjzVJF/0M3DR8p8TkGLVj9idHTgW?=
 =?us-ascii?Q?RJaOFAH231yB5lb8aiXZ5N3ONKJOBJ6g5XVjaszQIRM+GboOBrq3c1+zoj36?=
 =?us-ascii?Q?D/WsScsIXqVPL4nNJVcx5Fz1Meojqxz0HICno+yYc5Mi51d5/IJ9alTJ4tXT?=
 =?us-ascii?Q?csA8rA+BFMqp3rvuKhsRANJ+cOIZ9uN9EPsIzP2VpZi3WBbDCZL33SS3leEO?=
 =?us-ascii?Q?ph73hHNP9XcDHerwcRPlDPAmSD0P5QPxB07LOq8DWdNYO0z7onhUYpfrwHg4?=
 =?us-ascii?Q?a7hmuUYFYLGN7gflTYtbBpASW5pSqqEP9N9CO363pO8/sRfma0ReNEAiZhVQ?=
 =?us-ascii?Q?3esalcaR1yVlHoUvG4ujCXfbxgcdYZ4n1EcJ34YFE4RIgVayBsNP/+CDyDkb?=
 =?us-ascii?Q?Dv3u2SAtXYqoRu4pG8Oi8RtgJyyQN31Wl4zCE4284J6TDE5bmPaoUfIgCVE8?=
 =?us-ascii?Q?z4jJgVUNk7/6VaAKtzyYjUKW4QK7WvceT++g9hWpMbgP7qdzkKFmcLWAI0YL?=
 =?us-ascii?Q?2AM0dEMJWdrucEPqt+xhkCiJvJNLb7MUCLsskp6eONTgOtl8R4LWEWbSIqCj?=
 =?us-ascii?Q?fNsHcUDRIBUSj7laeoFS1u1bjeQn8BUmK+G0QUAZ2oOzrNRfph1K/H68yiuT?=
 =?us-ascii?Q?EMcmYfc1p6cCOH1GF5xOhojG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344fefac-a690-4291-2816-08d9118a9b79
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:06.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xshLVz/V2A18Uc6aHLjVIGNClvamQ6SYz10vQoJfRVSSd7uqYCCuT3he0nQDjEb/+03UYGWWGNpxFfoUfAR9lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Denormalization doesn't apply to the "no interleaving" mode, so return
early without error in this case.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index a60d9d275d14..605376351cc8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -838,6 +838,10 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
+	/* Return early if no interleaving. */
+	if (ctx->intlv_mode == NONE)
+		return 0;
+
 	if (get_intlv_addr_bit(ctx))
 		return -EINVAL;
 
-- 
2.25.1

