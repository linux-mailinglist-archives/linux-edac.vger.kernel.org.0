Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8ABC3F31FD
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 19:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhHTRIU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Aug 2021 13:08:20 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:35916
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231596AbhHTRIU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Aug 2021 13:08:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lq6y0FsQ9QmCop5YGw8usgwqLNQ82ZcLKidALqjkAYWDlxuuv6ipsX3vjmQsqLhvZx5HYxhB8pHqsDZUCOVANEae1xmLBhil20gtNeebogcV6CyJJDEQ7IzUjtgazk9lTADLJuN4sVnfaLK37KCb2OzhWw4WoJwOmOdCcsAw303VAh4SDETuCLGqQcWhTGaDoObUEv2I5auxk36RRGV9Q+LYOCTXjvhMy4+oYOXsP0TPrd9ZWHtoRvDMOzYIUOLxnujG5SvrtMcloUZBNMIt7NoQBaUETeqteMrlwyvXMVx2iBO/8XRIv/ofpCnQxjslEsSwWMz6JFkqAvlop6FZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2do2UMhDdbcC7CW+kArRLQWsm9GZDpKlPauXe2V04+Q=;
 b=eo31YmUeLBrzBnUrrwmcixvdvrYzAEwo830fBH1li9K4mdMNqdutK+kkS0V//PtLQPtb3U4toJLZjdVBYYWny8ClBAxgqxyK2XKcAhw9o6Lvo9p6r6cK2k/OADEv28jacDNIKkdnliHWU4MjU6Q4eTEAF4C/Kx9Nh4e+PCOpXWVlbT4CS96LrWQ+oFbzPkQVA4AL8M3mTPRtrEhTJNYVGD/Pyx3ZK7Tir3e3JW2LSFWe5jPc1E234syNZoiKBWGs2DZMxl5eDYhYF6jn0iRormTXJGn49q85eLJH9VAQ9ZpyH1GJWKE9R060UdqOh+ysSZTm4Bvp1w7kyApQ/udhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2do2UMhDdbcC7CW+kArRLQWsm9GZDpKlPauXe2V04+Q=;
 b=4peTJ21GzKYsgleWDMRKL7vLfCENMGLdWFsmKmXtiw4k8Mk4e/h1I8py71zc7JWgOSnumwFv7HA8i4dKoeCMvPq5S/gPWfo37Turr3gV+aAnAfwfFPGCVVlbMBjNT7sP5r0j0skYpjqHWg35f+b9UCmPScZgoxudgXfbbnNjKGk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1314.namprd12.prod.outlook.com (2603:10b6:404:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 17:07:40 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::50b9:34d5:d81:f59]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::50b9:34d5:d81:f59%3]) with mapi id 15.20.4415.025; Fri, 20 Aug 2021
 17:07:40 +0000
Date:   Fri, 20 Aug 2021 17:07:37 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v2 0/3] x86/edac/amd64: Add support for noncpu nodes
Message-ID: <YR/hWaP+I2MCmNW6@yaz-ubuntu>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210806074350.114614-1-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806074350.114614-1-nchatrad@amd.com>
X-ClientProxiedBy: BN7PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:408:20::25) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ubuntu (165.204.25.250) by BN7PR02CA0012.namprd02.prod.outlook.com (2603:10b6:408:20::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 17:07:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a868bd6e-b32a-4758-1ce9-08d963fd049b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB13142F3ACD580D92EB924FF2F8C19@BN6PR12MB1314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 054TQHGoXdbiVRljcisZjEknQnS005IXK2Hhsnwp19j4bdYa65LEtc6bq7qoLj54uAv3gDxKrAMXxwBKaSaw+Lwhup1xo+vH3vT/DPc9hW8PHJEqtxt7GNCVxi5i8nykH5aFR5YyBiJ1ghYuBBxe+S3Qyz6iUeNxWGvkpGroiWe8eVtISWCx03d5S1bp5VSUOIuSdyr3p+Qca8L6XnVHLTaWQmdEUmwbenqFV7y0gCx+Z+jmeeJa7YYSlvVGD49MEnxm5Bndhr+/IeAs8mh8fqoaTVVGdHxgjyfmtyOblF7wH5Ma6ajUgQshAJTHoJgDw5g+iFRp2NVeHDWEhgatptHPfHPcDt+gn2q/9oWZz2Uzd2pOXyIHs4lPIU2O+Gd875J3ZLCYFUAfQQ9e8eaaRkMpM3YsIJo67nieOYY57w2iNFSNZBLt62dzflJj/7v3+HIYIyWrYv2kpXTs8Q0u+yKXwc7JrJNzAgHQuCBg3ZsXWA5dGnHA+Ac0OtQjcdcLbQ7F+ISi7QbDkGyu3qgPv6BsCzAi5IzAq9+DBu8dO5lVJ5uxTAI953mZtTgpA6BYhc+5MYV3Yg1FDgPIua4bL+Tof5iI0HoaMrZnV/lb1/+sWYYxxUn2wIsPatnnzKVAxcR6CdiFU/idYmZnQ6Gc8C1zgwbZq4JBKLDgZomRgv7vdFc1DmuFE0WcI/EaHOols+R1F5o4xo1JvxU/AHTLg7Di2Y4Pj4XyYVZVL/8nGA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(44832011)(316002)(33716001)(55016002)(956004)(478600001)(66476007)(66946007)(66556008)(8676002)(9686003)(38100700002)(2906002)(86362001)(4326008)(4744005)(83380400001)(8936002)(186003)(6636002)(6862004)(5660300002)(26005)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HFKsBbwRMv16AeZiljY5qzNFr8QNAj7NgMyysG5jQlj8dZX0rg6A8NM/loyN?=
 =?us-ascii?Q?clRw6hLAWPpKdYKRuK5SPHcRzZ7PLdPB6Y/KF0LLgr0cKDgsE0MNJIXgCweb?=
 =?us-ascii?Q?6PBbB5+cHgp9qz7Vu0KBA/BVOJ19irPXLeMofMcPV9Kb7XkcC8ArDbaMS7Aj?=
 =?us-ascii?Q?hyWnaHlNEmTUF4o3fUIqWvnuCj9vmmdNDy2B13JzYOGi4y6LOf/QLQZkF96m?=
 =?us-ascii?Q?oEJwByLDV8ZdvvQUsou2uieSm+fBvMXMYD9/1wHscMhY3ZnqXU1sSyI+cpVk?=
 =?us-ascii?Q?ghsGg5fZxME5IYTzICClQ5y5EyIijEZnF52sExecCVEshhDuwzQCw79yR9oR?=
 =?us-ascii?Q?uOdbDd97J9Ue7Xw/M4XS9t5lMJBOoS+JTcB+ektQ5aMjhmZd5ZCcN3XDkCY8?=
 =?us-ascii?Q?qWeWx4BqEGJgYs64UHJV0NcUBArxpEHI9fH9E0yFM1wYaOv6dxj31wl58SoP?=
 =?us-ascii?Q?hqe/5BegUCvAM7F1cKfzK8lN+CstgfZGKWNZm3Mzrv4otKWRpyLHR4fT1/Mf?=
 =?us-ascii?Q?MQm4JjhGH3MnWVbMJhHEFqIoYFFOKlfigBhn9kDqZp4g8Fij+Ehf2ejkwxfw?=
 =?us-ascii?Q?z/hDiCwzMNRkWSDBXHKz439EforrqoqFCMrIdjm/7hrNvoPbBDe6CMocpbTa?=
 =?us-ascii?Q?FPdXjxfZOUg0JlaaT9qv40XCnMyzDh8ksxQLolT2onHB/RkW4bsIAARMYfD3?=
 =?us-ascii?Q?BTHaKMOBsCdhkMefcgZmmIQcUgwcLv+qIU4YM4q0luoCKjnCfITlZmg66JzN?=
 =?us-ascii?Q?IlkTDHU4c/s3p5gUnJdTMpS+fxln9UbR5a/llK42vTLj6fbqKdwII+q1GSTK?=
 =?us-ascii?Q?+7y6djiOMMKYtbMoPTcV7jOZHVakiMbvf91ctZgfDxgvKtqL/CbEB9DAvSxq?=
 =?us-ascii?Q?AvnbElyi38RSUcYyjEi6624qGfyGwshwz+SkA6xRN8jEjVxRgv+HJB9N+d0n?=
 =?us-ascii?Q?PuW7S8asBYxGrzHjqGcOcz930TjcFMdRORp/Y6114QVODMJNCRQs972iU/aP?=
 =?us-ascii?Q?ZrwrNi0AL8cifcFQ3BEGQ3+HdIUrc9rzD3eeDZfHKH+qkW0IgvcfBiDHXC0P?=
 =?us-ascii?Q?10quvw4RkTiE8HDjvXiK+hA0Wngm0iTMHDTVGs0NZWB+8vSX8R+gqA4CX/FQ?=
 =?us-ascii?Q?Ri5E1DcmHO3gFknPUS4cDkB3U3zLV5jE4evElWcAKvrkmSCkeJzg8qBgD8NY?=
 =?us-ascii?Q?19dXiuBf8RH+JWTCO7finjD+GaMaA0IJ8NwZynm8Kc5blsFHdQGnpNoL7Xr3?=
 =?us-ascii?Q?OUgzcoxf41PSxP8WtmtUgTfLDEuRFxIbOZZP280S/22pg8N4VJlF58FEP0su?=
 =?us-ascii?Q?83ZkWB1BRW9nh+K+Wcddl4ni?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a868bd6e-b32a-4758-1ce9-08d963fd049b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 17:07:40.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SaHR961hWXAfVREIHaUyNNl6zdxM8lIF9Rp8f7XMRyZGs4eSMNfdU4yCPq3xcQwlO02zm1J4TCzjy36nEjyFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1314
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 06, 2021 at 01:13:47PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> On newer heterogeneous systems from AMD with GPU nodes connected via
> xGMI links to the CPUs, the GPU dies are interfaced with HBM2 memory.
> 
> This patchset applies on top of the following series by Yazen Ghannam
> AMD MCA Address Translation Updates
> [https://patchwork.kernel.org/project/linux-edac/list/?series=505989]
>

Hi Naveen,

As I was reworking the set referenced above, I got into a circular
dependency with your set here. Can you please rebase your set on the
latest upstream code? I can then base the next version of my set on
yours. I think the only change you may need to make is around the 
address translation hunk in amd64_edac.c in Patch 3.

Also, can you please CC me on the next revision of your set?

Thanks,
Yazen 
