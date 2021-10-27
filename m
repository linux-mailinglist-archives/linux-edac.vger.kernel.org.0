Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD243D39B
	for <lists+linux-edac@lfdr.de>; Wed, 27 Oct 2021 23:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbhJ0VPW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Oct 2021 17:15:22 -0400
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com ([40.107.243.81]:46252
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244218AbhJ0VPV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Oct 2021 17:15:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X58soyHUmaYPGb9xDSIIN9H4f7c0DHdavl5bW9rjRDbHcOu4o2fM69OXO9ra0eWAuretIl2pMSiXhOS81pMfRRwqy0UAJXQcaUNxN5REzegOmwAkkSNJC/A1FbcjLAqwxwJETrlwsNQu2LsyxHj/20gzCaj2mQs8fSlE213XTq1telxgkBSRUdOa8DTzkQQi27AdsfYT5B0AFmoz15c0FI6oTzfnojX7jtYYY0WNeO0jL3BM1HNiR6CeWt1ImylJFYrsiwY5j5MqCjMlrkYE5qj93jjeNplOud/8oWKCli2KUenIb4rYkJldyLTJCJ7kmUGkvYCHu6SmhS7yvzzpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLJqLEFzARWv1xuUK6PW/nFLO3jaINa7mUBKsywbKNo=;
 b=M9bqDlUpXWiyuBaj1eYwJ8NEbd5UtGBzgipaB8XiZYCbT6Y23W22wLaPrznaWezuvF+ZrK4j5wq2BCCYv0QX8u8se7z7970koKw93RmnNiesBhasEZ1m8o3gfG7tbwdvRsOlN7kUy6aXCbthJ+wXl0/NpiBLkW6E/M1VAr6MQtPndeJ+y0xt3ITS0xzT4ZxLJpTyTOXRet6tbKtE8b98A5yHiM9A9K49n3b+xvN69HII0NbZQoD3HNHyyE/zr3ZDf93BWKyjEqQ3Jh2vQR8JbZ9DLX98cA2Y1PCh7ZWwaFwmEGytfXCX71Lo1i3Yy3WqtPkpG2s5paYMSnuyw+x7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLJqLEFzARWv1xuUK6PW/nFLO3jaINa7mUBKsywbKNo=;
 b=dut59KopeAdRGi605+ANwLWun3s+daFvKC0PwkBUnY9thiVQUaohwR08OKOi+WtYeCP5AtmJ3fvpsPCD5qPiL4DIa/EZB6ez83X5bRNN3b9Pn8a/bA/m+FcSt6ExRopjL1CB1n++UoJTvj2ovKqNPYq27IjDI0ZBU1br/CnCSwo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1700.namprd12.prod.outlook.com (2603:10b6:404:108::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 27 Oct
 2021 21:12:53 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e%7]) with mapi id 15.20.4608.018; Wed, 27 Oct 2021
 21:12:53 +0000
Date:   Wed, 27 Oct 2021 21:12:45 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v5 4/5] EDAC/amd64: Move struct fam_type into amd64_pvt
 structure
Message-ID: <YXnAzSrCtH1Jx2Nz@yaz-ubuntu>
References: <20211025145018.29985-1-nchatrad@amd.com>
 <20211025145018.29985-5-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025145018.29985-5-nchatrad@amd.com>
X-ClientProxiedBy: BL0PR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:207:3d::29) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BL0PR02CA0052.namprd02.prod.outlook.com (2603:10b6:207:3d::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 27 Oct 2021 21:12:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89dcd51b-4747-4727-675f-08d9998e89ea
X-MS-TrafficTypeDiagnostic: BN6PR12MB1700:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1700ADB6CDBEE0E3E232E4D6F8859@BN6PR12MB1700.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dS5EAOflayYo19D/ll2vddFlZAaHAYxpHMKbzhMnN6Y6mGoG3RHRZo7NFGpd+E3O7uay/HY/vZVTnIdzW0v+DAZCc0bo9DAe3YqBbdnc/2MLG6sHcWsm3T/5uRd6hSnwtPouJGCIlmrkXVFcL3NbtLStfKNRbN+c+zgPZq/oixJA0m/JYWqRNlil7q+6Pht+D3T0XoPQ+NEwJBCMP7YjZlZLIOZYPH6xQxJLPAXOgJY/IlM950hMA72SlKhipeaoB5Qh80eTgPi6fz/c9Z/5KvmD2L6x6F4mLPaMTj6epIL88T1BoJaU6GXq90500xmvu6uLJsFRpjurHHBxFp7/9ntQ2rbctfO3Z5ZuAKIeFz0yV9Y1A3RznUOKytmRrJPqgDBMguGuSZISyu8oDzmV/Gtz9TcN3c+dmdCXfgWS0DWKcizJmV5AokLJcCooc7yljImZqD1Bo8p5gV0SyKMt0s2Ygbf1hiobM6NFMilU2u1mz39wRn8+nh2JAjRsfqUFLMf2KLA2Snz0rjnsW+Aswc85bAVqYIzsq9xAawCDpi8Sk5gs4wd+4O7kU6u86rX2KPK+O42NM7gdAfmuYiV2kr1sMA0cfvlpCFWm/P5ehJq//rR+NFeOVsInoPnzOGoJ+OABClu4pUuH5cfdsaEVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(26005)(8676002)(6496006)(66946007)(38100700002)(5660300002)(316002)(4744005)(8936002)(33716001)(6666004)(86362001)(956004)(4326008)(2906002)(508600001)(6636002)(6862004)(55016002)(186003)(44832011)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pav/z277yvD9BT64i6Nf4YfHl//LpcrR/Ij6dmobcUQNEi+BjhzIQL15JmOi?=
 =?us-ascii?Q?gym81W//Js4YWfb5SKaxK7gIjI2HP8pjoHyK+oInWF4n5+2J+YU06N3Tx34W?=
 =?us-ascii?Q?AMHJmBvZlzIu2UpcI6wlIUagGfy25p1N3Rz/G6sjcsN4XLe31JOSOtSzPr77?=
 =?us-ascii?Q?AEorszLmR8uWmiL25h8EGqyPQzZHJfM1R6ZP4nFZbx+6oZTnM8b/9cYr8lx0?=
 =?us-ascii?Q?n+iS9dCUXwRr83mjsRUd1AwEHuAdiHIut09nt1seEmNXUqVd0yhleTnk0xHX?=
 =?us-ascii?Q?5/Mnlarb517ujtYFM6bKJ4lc7EM5qmSx3g5pNFgWHzrMZJtiod2Zl4oOEEIf?=
 =?us-ascii?Q?dpcVfkvhVd1nQl0ZoLIGD/ce04pL/exIHIKLUwW+1u8rNNy5kV6QVt2MJMEP?=
 =?us-ascii?Q?nh2JhK2xl1IkGgud0qOz1uAQ/qjvRsRIK81Wy2zacPdb68qSCY4KLkUKyz1c?=
 =?us-ascii?Q?Kfi9ZQ+2MSslEmW9/5WZs6BV8F7JNyhWguJRQyetnhV7e6HvvaJhmmOJ6BOM?=
 =?us-ascii?Q?35p6Xiaj+ORTcIpQ1lc2n7PKddGq91BLPZlE8K/dACow1BzDXIla8NUF36vS?=
 =?us-ascii?Q?LoH3cCJi5yZVD/msc/xP9HewCTeZ+70REGhgqcTr7nqctcp3dkL2mx+RMIA7?=
 =?us-ascii?Q?fK2BracqDkBoUJLbOIwQPrHdhbRtITBllHTgkYzHOYtJFHI5p5KS5mPoJ2xu?=
 =?us-ascii?Q?+FYVezKsofcYMuzsIQ4tqLiYcy/G/sW0H51Fi+40zhjz9z/5Pgjx4GjaRUCz?=
 =?us-ascii?Q?g5+nOePyvQ3xX7GWdiKnbUcKANWPB+OZwVryrKjH/SSpJsM5+kaFV8M3W6jt?=
 =?us-ascii?Q?Jt+j6DL6r5rFVQLB35dXo2MHW5DIWzf0DUf7Snba5kJlR7hVrVJgMxbXjXPb?=
 =?us-ascii?Q?VfVlSE0G8dHt3GfLAaCm0iQR3mFx5dTzkiwioiRREllO4bKRW5kmnprfrJ07?=
 =?us-ascii?Q?SAWiSPAUU9/kWuM7IGNkcZjMK5bYbIF9doyPgX8oJPkK19OeipEsWtBGlVYy?=
 =?us-ascii?Q?qNxAhq2HvIiN7lE+zrBhJrK9seBKdl9BWutba5WFCyTmOq9eY+kjtvl1ZPcW?=
 =?us-ascii?Q?Is+9cCKgu2ccvkP/H3Wu7RJHW2nhzVSr7AMResLJOOAjAdUeWsFa6STyZDVw?=
 =?us-ascii?Q?v4fY0R+4EWjYkCeZE4z7YgE9awor419vqbj6mUPDLSwsDDe8o4ZgITSu45ny?=
 =?us-ascii?Q?oO1bNQweZbOJm8MtCU/F5t59EiFSgaz7SzBURhT6j/u/2chcetjPTgPMJFS7?=
 =?us-ascii?Q?lYAyPKIIjKoXkTJTcKV2EcK+lfIEY5SAj0uWJ93ZF0hP0fKnvAB05r7EBUjV?=
 =?us-ascii?Q?7w2o08PjJF8xZhJctvDMapvPt5GQ3+EAsVOxfQyFJKalvJa1C1v2oUclEPZX?=
 =?us-ascii?Q?B5AHiR0N0+H2d/0VuvNykSlYq3Sm+bLQMRfW5aPnYBZU6gn7vrvHhQhuAm0i?=
 =?us-ascii?Q?v1mnmdD2luDP8nRLeaQ595MvEED9T4WAygUGyPsJjG1iR1jC8Uu99j1ALjyu?=
 =?us-ascii?Q?CyUE4FCBHn7f0zskPzV8Kg6ccgK75WUbIup0+0M6xvdOMCQvEXIRr4koihV/?=
 =?us-ascii?Q?Xt+LSdzLDYhOuHWcqdW0XDVMX3BrHqAJGwVVXpJX+aYonQ3X9fksSwKZeBRS?=
 =?us-ascii?Q?jNLPR3wKLGGNjJCquyMv6SY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dcd51b-4747-4727-675f-08d9998e89ea
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 21:12:52.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGo5Ck68cm/1jLX2p+zPAfmtxBX1DEVuCSz66D/a3VXFhrjtuN+g4S7NpzHAe8acnkYmsjZVba4HsyUEba6JIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1700
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 25, 2021 at 08:20:17PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> On heterogeneous systems, the GPU nodes are probed after the CPU
> nodes and will overwrites the family type set by CPU nodes.
> 
> Moving struct fam_type to struct amd64_pvt, instead of using fam_type
> as a global variable.
> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---

This looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
