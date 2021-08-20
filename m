Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF0F3F2FD1
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbhHTPoL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Aug 2021 11:44:11 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:12577
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241328AbhHTPoF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Aug 2021 11:44:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOXTvAwGL5E0aAbhW62McJp+BDhjFW8RZImDMfeSN3iq/84pV+b3wswVRN8NCwqOPiCSX6vaO3x2lXq33I4EAXw1U2q7BnTX/bZG1mIWQ66y81SYvgwvW5eEqqeoP4CK6PyGjRnJfzQwgKS92Lz4EnHY/hm5gFBl8+DPgrjWA991OVfcN4JFIHdWlme8m+JFPfFa6erajI9rqWHs+XyLauOXHZuTDaMdQ2WYGCbYPt0COf9RbqElpcgDjX+WMD+3foE8CUCcld0UoNL/FitKAAKluuQmYFqokV+VTwAJaynIM8jLFKMZbiV4ylYXpdNCA7EeDrc1NRP6x7KTZPnQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oJO0ePWHXyIGAaHTL9z18asVbqq3WV6f7TImni//As=;
 b=f/ueqzFNtuN0CB32S2iNPnewg/eCrpemKbS/fXFtemum5x8NJPJoTEsfEgLX4udNx9HzT1Jga50Q3bowqvmFoC0Fejxuk3LhYdty7BEgBEoEplsvy4Z9Bfde/qbtbPjwq7xmt4MGPMUyq/AiEv4/DLSCzh9bDTdue3m0ILoHMZQKNHNtF3nYzglMM+7UQD1hIl/juWkwDSqOcnTzf3qVv6Glv2Y9tWEgZqhdDW/5xzYDC0qXam7HfWw+x2HT2WjkLhQt7ieD6E7nMzdp6x59CXUW/fw0KuiKb+K7I8M4PzNfJjqt+l9Ou6ku+TvzWL8ISjZEbDlKIauH+Q4t4fqTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oJO0ePWHXyIGAaHTL9z18asVbqq3WV6f7TImni//As=;
 b=MkEsk4RylK0a/+YydMICjqiLhnd7pYJFtz8FjHb11bzWf026jfieZJ25Cur+zIrSsOxKrrXztztM0ZUUK7oF5dLzj183aVcXypa9SOR/MkcydsKFGV96ocnvT+83fCDJ+QGcqhp0jHJQkUTIm59dBklhNn8INjbl90wCCxzCImU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0209.namprd12.prod.outlook.com (2603:10b6:405:4d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 20 Aug
 2021 15:43:24 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::50b9:34d5:d81:f59]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::50b9:34d5:d81:f59%3]) with mapi id 15.20.4415.025; Fri, 20 Aug 2021
 15:43:24 +0000
Date:   Fri, 20 Aug 2021 15:43:21 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v2 2/3] EDAC/mce_amd: Extract node id from InstanceHi in
 IPID
Message-ID: <YR/NmdVcM7tYahOw@yaz-ubuntu>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210806074350.114614-1-nchatrad@amd.com>
 <20210806074350.114614-3-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806074350.114614-3-nchatrad@amd.com>
X-ClientProxiedBy: BN9PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:408:f7::21) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ubuntu (165.204.25.250) by BN9PR03CA0376.namprd03.prod.outlook.com (2603:10b6:408:f7::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Fri, 20 Aug 2021 15:43:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27c2acb9-c183-4526-6913-08d963f13ead
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0209:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0209156E60F2E3A39D80455CF8C19@BN6PR1201MB0209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MxTU4NMhaufpt9/jJvUXEVVFdFRA0OVRBlZ1bHHa5JgAfFFTG3R7zkCmJzH2bU5C+PRRVkA9eOel8MCsung8JKwCBSL4rNbzw3v8cg3nFYwWmNf+bD6DZCeBdKd/Rvb9keYp5Kj4LlHdKdYLjMWhfC77rcBXOMIDzgFvotiJlLWETE0fmrHmEb6fC7ilXnMluM3TCJRrrhixb1WqcN0uC1/VlQSxOt8nFg/2QBoLI5Z45goNJW2BxaYmrhUe8lB6qF7GqbcmZFqU4SS1FRfLNq3wFPRLc4LN2nxFiU6Bbwj17Af5MOHER9VNdyIo4elotyyKw/anTks7nbHI4Tl55t7rtI/pRf7BZ8nZHJMToVkE/nhyZgLDP+mJJwkPBw1q8LAns8gzwzPIoVFdxlHrS1vS/T6aUmCpqSTnPdSyAwl4kPXiOmnzp5L7lWvHrocSjVOSiyMs1rabdBi6Z6HbQ4Y7shvQk0GqNT4hu/a1YA3MKYqKISEXRtCrSx/rCzGMchU9dv3V0GZlCBlBepFPLpdUetYpvknbpt4k7etCuk1fadeYsfMVZ/pFsA+KGzEmodnvtK/Dfx1mvPR/xt/vJivVkkATpge4jPf3kOyoqGL0S9aQfIy4sl+Pk8ulP/L1F5xdJJYkPuSSshRjeJLHLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(9686003)(44832011)(4744005)(316002)(55016002)(6636002)(66946007)(478600001)(956004)(38100700002)(8676002)(33716001)(8936002)(2906002)(86362001)(26005)(6862004)(5660300002)(186003)(4326008)(66476007)(66556008)(6496006)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xfyRzNV9nQMvmBLOsvZ1ofVUxw6EZZ4Cmz5z0pBxr9TmwxMjoMSVROY7t2hK?=
 =?us-ascii?Q?n8OE+RKYXFwOc3xOd3dEdctd0V8vLDRlGAozdjG0SMqOQa7C+eE+r70/EcsI?=
 =?us-ascii?Q?XaRVe8z6eOuCzm4Da+uhjUcoT8YBgbfjnXI9NBI7Ub6Wa3ogyJvJYJJk9jaw?=
 =?us-ascii?Q?bwF9IYzyecvLpRA1F9dT9oXwKemNBwLpwMFoJ7THrsv9UqTQf1pLM5moZsrG?=
 =?us-ascii?Q?c1RdNZiP9/ywGwPnWuT1ycda1DwPYZ9JLQ9KA0cb7zdEGS7at6yTHKdanwHU?=
 =?us-ascii?Q?WnA5hHTt6zjwnhprkh0tl0UvmIzQGMYn4yFA/Zq+r8BH0Zfo4W3/OL2ocnba?=
 =?us-ascii?Q?rv5IXDwaOSlOmWj0Ih44O3FRps4SWbx7o2EOZWC7YlT4fx36G206IPW9hTVf?=
 =?us-ascii?Q?1iYH5PG1XIPau6bOex5/34Jl0t/f13sDs+anA5/bpZnnYOIgGi+EoCnBXiyR?=
 =?us-ascii?Q?iPaRdcGfpyydTFPeGwbNqZl/+f8UCAO5E9XoI+ULOw2MeIBaPoMWFRtWG88e?=
 =?us-ascii?Q?oMEaf2gj9V/JWZxeBknTOe7Wb27pBxuT9OMHsZk+Xm6plxae9QgkUThvrVYs?=
 =?us-ascii?Q?Ku7by/9i2yF9t5sm+z27zRRh1uy4mLQfRxqaa5AEjhaRd6jAlajli4Dwx7Cg?=
 =?us-ascii?Q?/Cb7CFh14x2hA01PuA7aALGzGwIBk2n+oxdk1IPz9DwJW8+otO4EcqOyO9b5?=
 =?us-ascii?Q?Uvy5z9HYO4HR8EO4XUPitWoYG1CvkUJ53iooVNofxe/MZ6ibqV8NAiT4WLCB?=
 =?us-ascii?Q?bJGMMCxmdUfq1M4YgKYp6ii6nGw9stAUiO8KkWklOVZqpZLLQ9O0p3mHRaKj?=
 =?us-ascii?Q?I0KWQXYPLfciJxd6la+Gto5Qu4c/vKwWVDYWXHhBhrydOa6dwbpsiuv3bm9R?=
 =?us-ascii?Q?U2PgIJGu1TVxnrrQUg1dP8vSF+Xzfbfapb4iUmJZ/pBKxiJf23DxjhhNym8j?=
 =?us-ascii?Q?8VkdUSLKFvmeDuS3Q6MaEZELhvkDT03lS/GOfNddQELuOCZvjalNKuolkgbG?=
 =?us-ascii?Q?f7PY3dmWfpZCVNTj9fVjua2jA3VgB2XqZqVnxz3tIzz09MxMCn/OoyhFWxkN?=
 =?us-ascii?Q?m7sgbBd6SL/VLMV77Exxz3LgSIEkkNDBzVA5Jjr1l6ebwS+scjsTUu3X+Gub?=
 =?us-ascii?Q?bFmq4ljSDqEJ7CQNTkTbM26WqTq/He7t+lR8fs4QQKDqM0ri0T8goBGHsa+Y?=
 =?us-ascii?Q?YHE9cXt9BeRWOvuhQxqL3kOuiu4nEYjGaS2ANIUtQ54hZ5UIG4QPWKzZPllp?=
 =?us-ascii?Q?lOHqj765blgrpHWttUnbtifdjhwDS4r4CxJOR6zp/cR3GaXFHY9B6b/xsx50?=
 =?us-ascii?Q?QwzwMA+mFO5f4H/GsoFIu4Pr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c2acb9-c183-4526-6913-08d963f13ead
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:43:24.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m69ZiPXyiHOEA3QJmgwF2DeHcG6HNPvUxmDyS6b6ki6NSPaLdXYEJhr30g2K7OmCm/na4OoT2CAuZb29DjIMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0209
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 06, 2021 at 01:13:49PM +0530, Naveen Krishna Chatradhi wrote:
> On AMD systems with SMCA banks on NONCPU nodes, the node id
> information is available in MCA_IPID[47:44](InstanceIdHi).
>

The bitfield name in the $SUBJECT is wrong.

Also, the commit message implies that this behavior applies to all MCA
banks on systems with NONCPU nodes. But rather it only applies to the
banks on the NONCPU nodes.

Thanks,
Yazen 
