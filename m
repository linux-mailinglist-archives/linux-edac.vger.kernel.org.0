Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B6E40D024
	for <lists+linux-edac@lfdr.de>; Thu, 16 Sep 2021 01:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhIOX3l (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Sep 2021 19:29:41 -0400
Received: from mail-bn8nam11on2052.outbound.protection.outlook.com ([40.107.236.52]:25184
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232907AbhIOX3k (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Sep 2021 19:29:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCYrOvCvIGYUKfEtI36SuCzUo0P1b3kphMDLtzYnygK2nSC05OCnAs5aghD7UnY4w7/ErTHqZcM+iZBsHuaWO5mV23cvo7ucwxSAbcnPxtsI9sjRuadyHOZW5xBirKjPAqauyh8SrUow7QjPuOdKKLJQYyNxDDY4raXmZPTDQax/fur5ab3QxZMt/Hp59Ut4MqFWbi/PJ4TX3ScGT7QQEdzPq+q1id8UNTRcWf7mV0FM0PeczM2d1zvtj1rQizPL6oXkC9VbvhEvtdNlMkudYnWwVGf6tcSZWb7UszFEcSzsZK27lo1ocbo/z5iqDFpUX/lcMeLaFpRpPAXDh/sVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gn+BIZo+3kEW8pu3p230VpLuWV6WOqfuW10ESJQ7pHM=;
 b=alYxazTodL04yHs9RZRIsvHuTc8zAmZcXp2SAD9ibS1oIiZ9ZwqqVqME2U3rCO+Crtd6EFxms1vtMa/876PFmLUM0jF7G8dJMpvxHc7Zm1To9OvG1vmDZVICcmjSHgZxixBKeJWZxren88u7cOe83q94CAPtPnE3xfs+sBx3KeeV5xihrnvK+6tog5qxUQeCfGOfafDU5vdyr82qkA506VYsdI9ZjMpt3wj+rP4RLpAXuxxaZwFJ8CSh9MVY7T0V1cyzFbzFz2lgNqpLsrQf7GR0DlVU36+P73FFxNWUjkH1WGQS/SnLhudNrp0KPK5PJHpEzE/GUy8QirSBJl5SnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn+BIZo+3kEW8pu3p230VpLuWV6WOqfuW10ESJQ7pHM=;
 b=i8iLuT9+UqGcL7fVbucBD+iQMzpDF5GT01yOaHv2j6R4U0aYGzi4zfWrJFdYtMqb7gKb5Lx9oZ7Yjs3SZf0kTWa2E0DJMTmjfB8kP4cqRhiqwu6iW8wWIDz0T3pMQVt0wHyf/YjXB5CsZMLTWtc/xbxTuSSjL+t6VmRH94i5QnY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 23:28:17 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c%7]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 23:28:17 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        yazen.ghannam@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 1/5] x86/mce/inject: Check if a bank is unpopulated before error simulation
Date:   Wed, 15 Sep 2021 18:27:35 -0500
Message-Id: <20210915232739.6367-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:408:e8::20) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
Received: from ethanolx50f7host.amd.com (165.204.184.1) by BN0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:e8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 23:28:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5611271a-6417-43ab-9b6e-08d978a07f46
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB451232CDD71E857C6BCC842690DB9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +afVXCbq4ULznatxIk/4JmQkv9y8MACQZa1CevxAXUhE7Q2AQmWg/P2T5YTObrmWq5FSFVxqAsA7XEguJ0uJADbl92R36e3F+XjCVp3JbfKeOUZwzDHsWT/NvTdZ863HXK4a05ORVkYr+dMQURZ2+xUDI1AYk+0lcXZqSHS9a27nxh+q0rtscBEhmGV4xWLiLsWOM0qwH+BhVXtukwH8K3q+j6U6+fbz1XuF2IDZM59lPIbmo5iqVoOVLgFezqHTsbEshWvXHhywbIM+dYb//gRpDY10jy71g2Hrh3KcdQPLVfw5ozLxEQW49gDSpa/4hdScQzjVuFK63cO39yJ2Y2sgxaeAy/YsE7huc3TA9DV4l3xo453PenKvunijgtfbRZVR8oAYzL3lQ03fe58tMv1AyPT4Y3MFyMbamjL2sXFnyhqOqTXzGjAnA3pO3OLP7MkP++7+kyOv8RTkZ3IQrzREraz47N/I67sdSyZb/nNwVPgCB0XuPPnTxJoWue9pjxDQjPdf4wX6a8ObfjXp+J/zKIzXk155tz+ndGjRjKktpNT+aUGUHCdyGGtUqMBtFXbKTVQvA3K6TuYS91Srt7x/G04EQPJAIP/y3UOoCJ7HM84yOWFscnp7SQvOI+er0XxfZ+S/Blg7DC0O5QHn/S+MOAV7A6uY8s+kT5r/wMj99KxFjhzox7Zl9rJMq5r6YsNxqeWEK+bFmDwypSpssg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(86362001)(956004)(2616005)(66946007)(4326008)(66476007)(83380400001)(26005)(478600001)(8676002)(2906002)(186003)(1076003)(7696005)(52116002)(36756003)(5660300002)(54906003)(38100700002)(316002)(15650500001)(8936002)(38350700002)(6666004)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RL6V4hveLoTkPn0tzjIJ47wCVxxLPd+BZmAA6Ub4RS22TUk+TF+3LpFKAgnA?=
 =?us-ascii?Q?q9MFhwsGjHulxAYHXK5hsb2mLpIFnLv5j8B4hXyWy3hXuhrN7sZG65RWHfcg?=
 =?us-ascii?Q?0p18PzLmd44O9xbNquuGwjF/1JmsSdMgbLnmoUCGnq7wzoVIXwVitrOxoxlJ?=
 =?us-ascii?Q?dspUDgMEMSCtkN0WmdnXlmgQNo25XN/9j+qD7CmLsm7qCFoxKQoSwfuDVLJz?=
 =?us-ascii?Q?4BpEyXzK3hbI4UZHO6HZ3WoWEErr1v65cIeQpYoGoQ9zbDxNMav8Hl1MkWl7?=
 =?us-ascii?Q?XGq33zkjRu1mgULldtngG6X0uJ5GopCel4zJ6o1L6GYGwkbdtGFHkHn7t7Bi?=
 =?us-ascii?Q?j8KNtyxxydGT9R76/8zFdM6lE1YYpkB2aAmQqemphyBETUbZqdnwSUa0XTE6?=
 =?us-ascii?Q?9pUTFZY5Q+/jJmbIcuAJbkGtmeqMKD47sDv0qnoIYJ8RiBn0OhxLWXjrA3oo?=
 =?us-ascii?Q?jpwrcAdwO7Xtl9s2rXIVje8DFknRCdSaXPwpJlXzbXFg/ZGEjkz5rmPGvIqh?=
 =?us-ascii?Q?17L9KNqCGsLjBqlwGyCNwtOpFBAyaMGalOz9UFHX7STB7ai56fuyXjWrQrIr?=
 =?us-ascii?Q?ydRgQD/iy6afOtkWb6Pia8gKGenO1DxDvaP1eiszudM0RYka6s5BTbjgtp4D?=
 =?us-ascii?Q?n98j3dbAr433N1fDx9l1Cjr6GJNHEexlw/XUe6jGXo50H7auJcju+K24mQ0E?=
 =?us-ascii?Q?k4hcSmTgoLFYrQEKxJ08HDj5ueABEIO5qajebCwX3yLULmsRrwcOc9KYRJZi?=
 =?us-ascii?Q?qX8Qd6pXgeQW4jCu8niq6DhTtYRbMVR/juTTDVLfJqSh5wKWhiWKvtjG9BGV?=
 =?us-ascii?Q?RsfZt1Kwc0MLh9EX+0D26tkRXQ9VzftOVnr6sWAuFdohGfNERrU7eh33pLDm?=
 =?us-ascii?Q?UEugBQXNOgvvNFCATHTOXflGyRX/0gJR2msHImdF7tFvoD4ronj28XtXKhHg?=
 =?us-ascii?Q?WB8O+iJGtDe67crHXKe1VzpAiIu9E5WylAvfHsns16tr7fd5EnuTHnmFWA7Y?=
 =?us-ascii?Q?hOlS1mLZZM0eXToPAwZ9J/zOgHNXhktYsATBP6zjIY5sBfTkdZvM/UKWCWeO?=
 =?us-ascii?Q?wgF0EicueQ1MCq8+tAqPhpGYc4oJVxCDxnNe4HUMab7bbTG26n/xoyhxqdKB?=
 =?us-ascii?Q?wvkHXWEWVuYsF4MRmfF6+atjJwM6yfmKkbK2fobUtGxbkvI9MTI98MOBZbiC?=
 =?us-ascii?Q?e4B/1QsWYXnLduwLZCOpmk0ArrIVhMFgVhA6SLf7YvGKh7sRHCjByU0znvLL?=
 =?us-ascii?Q?nONCQSb6MjRnJdsp0xTlnHo744C1zi8F+ZO4G+rg+vKrQLezPIf4cymxOto+?=
 =?us-ascii?Q?diIiQLyqdbIx8s1MZ5QSyk/G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5611271a-6417-43ab-9b6e-08d978a07f46
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 23:28:17.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRKAVWvgBa/nI/FY6S43du3WcQBGUqnT9fEbEIRx5CehXnCHlFqSedAdNk9jF0343Y8atn0kTpzkQ38r1RbpTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The MCA_IPID register uniquely identifies a bank's type on Scalable MCA
(SMCA) systems. When an MCA bank is not populated, the MCA_IPID register
will read as zero and writes to it will be ignored. Check the value of
this register before trying to simulate the error.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 0bfc14041bbb..51ac575c4605 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -577,6 +577,24 @@ static int inj_bank_set(void *data, u64 val)
 	}
 
 	m->bank = val;
+
+	/* Read IPID value to determine if a bank is unpopulated on the target
+	 * CPU.
+	 */
+	if (boot_cpu_has(X86_FEATURE_SMCA)) {
+
+		/* Check for user provided IPID value. */
+		if (!m->ipid) {
+			rdmsrl_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val),
+				      &m->ipid);
+			if (!m->ipid) {
+				pr_err("Error simulation not possible: Bank %llu unpopulated\n",
+					val);
+				return -ENODEV;
+			}
+		}
+	}
+
 	do_inject();
 
 	/* Reset injection struct */
-- 
2.17.1

