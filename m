Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4A3C7466
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jul 2021 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhGMQYx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Jul 2021 12:24:53 -0400
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:57436
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233762AbhGMQYH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 13 Jul 2021 12:24:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiiOAyIwEAUuVzRjQYiAUFtjzeoHwanAcVKtCXjs0PxyweJVMHaq59cBC+tkSC/2fUwveH7ok4VTZu6l9sr8smtPwPW6iwbPv6CKPcsBC9RDqHFMnKJrldPLUdydCD02dgBWaDVE8yR72dTCNiSc+FCxJ+NLrUC5fiNXoERnrHtAr+Y/4a0YGGmIqAJiGFa1DsjAxn/ddcla/XgZolZGgZsgkPO48RIDL9vsLY2gFemM5f7uobbiRqKJPVmBSJi5hC5zQBCOK614ua8PJS+EsMlHVMqf7hVz1ONQiItV4OK2QyKsI5VUkbDyRoehJ1XxHNfzihQJjt5YLqH11NWiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Emv73g5gNy0ReAjzPBcbF3Ns9Orcbjf+eCQDtGlksU=;
 b=Dl3IHoI30U9YfN4sAx6KusXxh9Md1jCbeDWiho7zqJhfJzrGj+UVngWdZbBUgmLuZYBs7OY4rnRgGagy4zvmY6DKEHCrcP/7PXgdhvK+P6JYVA3HFUAudGMM1v4vBbOoOoUduLyTZioTRc0iqBS72esJhERNzy6A+06EqE2bA19jUcGBBEgTcszEehWZRFrneZz8WIVXTuA3mphex2v2o/7JtK+nwVQuwvhLCLLp80SeLVeF51/cXdoMIbrhdmen8pZR4F9VbgmY/YAOT4+20geRJkoTB8m6YD3z4i5z3eQwqETqAn/bvBNJzB7hZmQyPmm0nObkjjquRbvdsq80Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Emv73g5gNy0ReAjzPBcbF3Ns9Orcbjf+eCQDtGlksU=;
 b=mCCzUntq05Ns//plwOG944tRkM3HTqRXvf++ScN/lrFISTQ4AqExexw+dtPsUakHNjXbazIRxuGjRShRyduunublVwAblNGwX6FG12Gnj0rBMUU9tjvhYOzhRWPM+uYY23HOH6Ls7B4rN2xBPKpFSyc9OGFDpcZa5ISwMu9XV1E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1316.namprd12.prod.outlook.com (2603:10b6:404:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 16:21:15 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 16:21:15 +0000
Date:   Tue, 13 Jul 2021 12:21:12 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Muralidhara M K <muralimk@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Youquan Song <youquan.song@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 2/2] x86/mce: Add support for Extended Physical Address
 MCA changes
Message-ID: <20210713162112.GB16744@aus-x-yghannam.amd.com>
References: <20210625013341.231442-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210625013341.231442-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625013341.231442-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BN9PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:408:fb::21) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN9PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:fb::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 16:21:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ce61b99-303e-49e9-4bc1-08d9461a3caa
X-MS-TrafficTypeDiagnostic: BN6PR12MB1316:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1316E7F1D0C467A314AD4250F8149@BN6PR12MB1316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gdeOEj9nTrAm49BWet5uKnq4GqD5UfxpK697v0mI2SgTDvLbVyIPPTNb74m+tEWbeX3FUVFmnnPGJjGAxkniR8ndAY+pRrUApMdcVDw4jShX/fsSJ+ygBPxn4mfG1rEh23Q7QKSeHnJ4G3/nxIUaF2ZQ0f0HT1Mf/+m9twBaY50C/q/DuHEfnhb2ZVBcGNnAEtnK85inGhmomuTNGy1RJeqeUBH3/+eDw3I9Yl/DrZ3pOVkJe/VP/ehKBC0BdBdiw9sWCBdK53yqDDOLB/sJUDV85EmSQSie9KDsNIXogKU6XwE5qxEXPNu9n1C1Y5ZPtgpGJ9kkkH7n3CC7fewKAGlQV+tjBz8BK3iOklFb2a5nIyD13zj9F53W4tgbg87xfJ3Mp8xD9qJthT6HAltN4e7+bhPbfwbsQZw+9oOjNq0LJLsDENw4V0Vzt+CMB26jS2rf4FuxMahLWdbvmLYTkks8dC/YpnqjpkvWMuw8j5V5CGRkAIa7bINbn9U6wYE062GcitElJ+btpKB1ZC5aB3zWsC4UvRpk5eVKhQLPxLJb6dsgPj0DCKgONukTa0iTkaZo7rAgKXRlz7QogRQyJNxFF+HYAJNtQeRQ1nDZairxUC/R0WYkUHhG+oON2wBf+pEhf6OZoKxZ7lL3q5t8qMtc5p3dMAjW5qZuM8jSnQiR2WatfIA7dxmbJJTCy2m2kcRcQH5mawyXdCsM0PufQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(8936002)(54906003)(86362001)(316002)(66946007)(66476007)(8676002)(478600001)(186003)(26005)(52116002)(7696005)(4326008)(66556008)(38100700002)(83380400001)(38350700002)(6862004)(1076003)(956004)(44832011)(33656002)(55016002)(6636002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UxgAmVIXJ8BmSn15deJxYXF/hYqWdwSiNpeIMXvUFgnD32VmEu4YJC/q2aWz?=
 =?us-ascii?Q?QoEgo0/KNVgG8D+tSZJrPUmPTIVYREivmkF8ccyqT8DADN7LEsH8BpHyNyLY?=
 =?us-ascii?Q?DB5nxbsqkpudXrJi9cYlLSNwpTOTtQnalDM82Qb8eOmR2gwa1PYNRRhLXKFI?=
 =?us-ascii?Q?jDTecFyBA504IvG4mv/NaI8n/gBP+JBXcI0repXYhAjG2AJ7SmaoCkOpG41+?=
 =?us-ascii?Q?eEQmJg3nRw4PAIbls7ehYim/yMeBxHnxnI1Qdcxmxg23TvH4corH+Rel3NEk?=
 =?us-ascii?Q?b3OjJeU8Q6PqJZa8ghja58AbNycAiQbmNqCgTArFkontA27cGqI/111IaJ8e?=
 =?us-ascii?Q?ULGyIpIqeIvnG4AFDiYe3FpWzDd+w5876L8hpusy+1k0+Izl48rU7rpcyrEH?=
 =?us-ascii?Q?U0kgd1O0QLsWZsngrPJrlOKJpt02yAV840gOcHQHT3bwCulfGxYhTEEvx7Gw?=
 =?us-ascii?Q?gpcO1p/ODJYoyi95drF395uq4+FqtBVadgA+/VVV2+t7ipD7d2AYGlhyReoY?=
 =?us-ascii?Q?UZmE03Xv3wfL3VNxAk1kiFJrrP9kLpJGIxEoQdSa+9PHwurvcrLrJcU7P56k?=
 =?us-ascii?Q?+xJ6SsXo1/9O4BCSWTFk7nsB0iHkkP3SSQ1i8BMaWxAxYuGE0wLZW2BZe9Hi?=
 =?us-ascii?Q?XTlUCU5nIBZbpaxuPVlspKV6tmB7wwVZGiO0RE98M6RbRv1OkXYgRjKOFrQu?=
 =?us-ascii?Q?kNbM4b8aRTrIPVgv8lHoIYsQHprNHTJGj9KzHFZdVHe522W9xRusA8OT+O2L?=
 =?us-ascii?Q?3pksCgQjefhi9aCqKXyY6YBLyqvFXrfPJAFb2GekwEQ+R0keYAse56Tf6tZS?=
 =?us-ascii?Q?dIWeCoWzboqtI6qXRyk10yny55b8aDUBAmwOAzf5jQVvUJLhxB8ZLtLpy5B6?=
 =?us-ascii?Q?EQ9mqXdOhC7QrVKv32MfNtYKFAJiddMyCxFCA8DvtTaph3rKPyuxySbhvG2V?=
 =?us-ascii?Q?nlj/myO/Qx6Lgrx172dCWvs3pxY+6hd+36y278/h92UISpIKQB67ui2VMQcn?=
 =?us-ascii?Q?N+kA4bnVHLFmaAIjsRfVZdWxlozXiMcG6Atddg6MJCFpY3j6jHxa4wel8Obi?=
 =?us-ascii?Q?u+91ejcLck2JS6fU0aPJdcslDQVCk/FpCBtpUNYP8gea8h/gPLD7bd1u1Fe/?=
 =?us-ascii?Q?7ZLLKT0T7t7pXV2xDrmJD10u7gCNs+HbbcbtnqMZSlbIn5yOV35lUKa5a15I?=
 =?us-ascii?Q?r1PlYKGGN9GRva/1iOAfjwbLXonaUjrWkCvSW/U3YS3nP6Nv0TBYAVRPyLkY?=
 =?us-ascii?Q?J+GJiWFqgez2caV/fNMx9t0GNHnvwrnKPa5mYwFMpk10puz9RklUhV57NJpg?=
 =?us-ascii?Q?o37FZX6yoqlkVzJ2H2e1wtio?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce61b99-303e-49e9-4bc1-08d9461a3caa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 16:21:15.1772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3D3yHDb2uEcm5SBK1sdeSU7hCz6GtXt6QUgzPMTTyF8xBFgq8Iu7dgGUBpQO5IeR1dvQxcuweNUv8qYMWSDusA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1316
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 24, 2021 at 08:33:41PM -0500, Smita Koralahalli wrote:
> Newer AMD processors such as AMD 'Milan' support more physical address
> bits.
> 
> That is the MCA_ADDR registers on Scalable MCA systems contain the
> ErrorAddr in bits [56:0] instead of [55:0]. Hence the existing LSB field
> from bits [61:56] in MCA_ADDR must be moved around to accommodate the
> larger ErrorAddr size.
> 
> MCA_CONFIG[McaLsbInStatusSupported] indicates this change. If set, the
> LSB field will be found in MCA_STATUS rather than MCA_ADDR.
> 
> Each logical CPU has unique MCA bank in hardware and is not shared with
> other logical CPUs. Additionally on SMCA systems, each feature bit may be
> different for each bank within same logical CPU.
> 
> Check for MCA_CONFIG[McaLsbInStatusSupported] for each MCA bank and for
> each CPU.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

P.S. A good test case for this feature is data poison consumption on
Milan. This case will generate two MCA errors. One will be a deferred
error in the UMC bank. This will be handled through the deferred error
interrupt handler. Also, the UMC bank does not have the "LSB in Status"
feature. The other error will be a #MC in the Load Store bank. This
bank does have the "LSB in Status" feature.
