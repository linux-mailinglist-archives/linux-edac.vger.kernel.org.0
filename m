Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA446677C
	for <lists+linux-edac@lfdr.de>; Thu,  2 Dec 2021 17:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347822AbhLBQFk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Dec 2021 11:05:40 -0500
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:50528
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1359229AbhLBQFh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 Dec 2021 11:05:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSiUWeABNlASZ/IHua3QBR96pjlmLe1OO4bEzU83Wwg4zatGtJKTfKFvmsqw2Oc63b4P7zwfY1tb6cwb7w2UNbMTIJRk+g2OS5BfCWIA3d1Zec4JPJ6zB62MERbARGo/G3pO3vFEtF3EumTpKGiVY5nkvoR4VK+DpMxNM+AcJBU3pktF5bSIwzKTCGqT9Zk9E2/T9HOVPgjweSaNgPTBkdeHlUvpu2gVDqpuFqS4pUVNPKzGJfwHV2M1z9ZYWvgVcJ4qD8LDakXDgsl6HEdP3DZovziL1rKkAialCFb2GqoxnCV/LjBRh+cWXjlT3tR5lWqIE3/KqAvu6699yk1gdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmx8x5K43g+AVe97S07thBdrz5IfgXqw48M8s/oUf+M=;
 b=diMYNEi8yxMRfXdA+6ZOECDilGExkwMF8w3BovbB75M4jWShq0AFW1AHyShOFOUV+hPLczQiaCCwvzcGPBc/YjMxU5w/axsijuVO3SL3egeSSUukGmW4eRUoRA8MdS7VEdta/GNv4gkzEPEym/tj2wMUgmHutSgxQMPh01QW4g6qxrckmm55plD3XAGgSNBsIeSJpp2zqqtzj2MjNvLTByINlf/Dhm9jWSfHmF9f58GuwU7A4XtSkTkHgsiy5I7q/3ZBl/9zYxuttGpkbHknp2Uz8PlQmfyZtOvClR1zuhfsRHNq3EaBos+fscrkuyhf8884GWKJ8hVPkok07kZteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmx8x5K43g+AVe97S07thBdrz5IfgXqw48M8s/oUf+M=;
 b=l12JPQqxdL8lqUNlBe5JxlZfSEsjdTnGyzRcGSnBpUwT/U3dDNJfHpwMjRWs6Au7cAm/oPtzBEKAFHDYuWbSI4EGOD79vB0cu5MgOkC3Jmekid54s51cFXV+AXnHmkxhg5DMs9T2AaNp+waWWuPnxLKlWYgy9qU91eFBVeWuIzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2978.namprd12.prod.outlook.com (2603:10b6:408:42::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 16:02:12 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::dca6:dd72:888a:9db6]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::dca6:dd72:888a:9db6%5]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 16:02:12 +0000
Date:   Thu, 2 Dec 2021 16:01:59 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Excessive delays from GHES polling on dual-socket AMD EPYC
Message-ID: <Yajt9zml8Iyd/VVn@yaz-ubuntu>
References: <878e4019-3a88-798e-4427-7efb5289a4e1@ispras.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878e4019-3a88-798e-4427-7efb5289a4e1@ispras.ru>
X-ClientProxiedBy: BLAPR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:208:329::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.84.11) by BLAPR03CA0066.namprd03.prod.outlook.com (2603:10b6:208:329::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Thu, 2 Dec 2021 16:02:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64518a33-275e-43a1-5d9f-08d9b5ad1a16
X-MS-TrafficTypeDiagnostic: BN8PR12MB2978:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2978C0F95F1E9A527B995551F8699@BN8PR12MB2978.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQhN9P85VOSscWAONGwIePIBiisg34EuA8rufc+wqK9vDC25imKy5Perg5FvrSJnGlC8gjghXp77YnVbQrAfuBekz8Ez01L8hR7kfmjhvNdU/qkNHPzq73OLjEO28rAxijf26Ll67mzlAGd7dh6dhbzVKmih7ZBJL3Gf/vlI/iwp00Ef3xB06fPLqGBy575QXjAAdmebJMVCpX3FXA5ymjrFTNF9kcvuc77n3S3jY5dWyaGdpcaFIZTtNnId52Mfu6eIi5vjAUluMbFSEIWNVv//FklaIqfaCt4QCPJWDoAwaNZqVwhSAl64wFdfYWPkN/yjQ0m89jf5vZx90aimYV1sopwtpTTDJxDerZAX2/tGpjgsrDxQNTM27s1PgwhIuYCdRM4Aqqp+hDyTDqaJVw0PwED7d9qxBo/sIoAaCn2Y5o5u57ugaV6BYOh8UeEE++YCMcahpIgNZNly1ETTNn2/0DS2Ch7pTUUJONbqBlnQkw6vF0wkrFIQ8QQRBYkMFJtrbH9js49gwtiYL3rFyIFyMB9Qs6SvARqdItbjoYC4d5gtbPzpi2oK3q3Mn0UUl+JOSiia2LmNgTE327KNcj9loXOG54L39J2yJwJhU/9WhvmyWo51vHkAh7/KU86SN8xEUE1H8GIeWnt42PpDJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(66556008)(66946007)(66476007)(6916009)(2906002)(55016003)(508600001)(4326008)(6496006)(9686003)(6666004)(8936002)(8676002)(316002)(83380400001)(956004)(186003)(5660300002)(33716001)(44832011)(86362001)(54906003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XlBzTq5e19AaXEQAeT+edQDtTALQ7q0wGryc/IDIarKRyH7jFj7iwp1qedSw?=
 =?us-ascii?Q?+3rgvD06u+Vg1shsFzeMAvHTrdqgPRoTYoUa1540ieIJpBDstHJP4WOGtlK1?=
 =?us-ascii?Q?F9Ro3+YyqwTjN3nrk6UGDxC8RdtTcVk6VHJrqp/DxBnAF4U0qMUEKcDZhVd7?=
 =?us-ascii?Q?kMGg2Py6JiMx0uFC91XA6gV7Zsr7aWp0kbP/7wA/IRW0mtPwAyTHUA6bKfTQ?=
 =?us-ascii?Q?lWMk7L8IaFIvyZsgjfkVT1Mq8xEBysGHuE1npJwHNwpyQlZQNPdd89gdCi1I?=
 =?us-ascii?Q?+qacZkuAjIs1sOLO29dYvw94jbSGY7GfLEzb/eJEpiLFc7flpa9Q+BXEWHja?=
 =?us-ascii?Q?uA6OaUjCr4fHoq1Cf+ireVf3pAU1MsxtkOi4gkT1T8n6tqChAjNCIiXtQKXZ?=
 =?us-ascii?Q?p9/q+y86xgQAiwVvdS9n+rU5O9pV5aad/gzWZAQmeG5pkuhqNsGhTADPmg+C?=
 =?us-ascii?Q?ZCCBmchmlQFf/KkdsvhUZMXTCxGIlFQg+hEM1eCRFyMpEvdVyhHd/PDva6l1?=
 =?us-ascii?Q?n4qkxKHpElhUTcXDh2nXx5PFOsTMi8A8BMkhwBQiclz5XyFxXUuRMU4G9Mch?=
 =?us-ascii?Q?xWFZdW8Jb/V0TMaaHg+PAHIY1AadCQ44/VooaH6qzxRT5dX1n8BRpeI392pi?=
 =?us-ascii?Q?y0GXyVy9nNZ12Bk+NSQ73S0MzKFE8fFWQIDWsZ3dUrm9kQC9GfgQgXm0ml8S?=
 =?us-ascii?Q?45ha+B+p66UDivdmQ1jCSOB4Z7in5XcN4UCWrPxrrd3iR8MCaz6f+k+EMm7C?=
 =?us-ascii?Q?NV7lY2+KWaxtfzqZSAyMLa59mzp3KR1z7Liyo8VH6vOeurEeQU94AI3OXqNa?=
 =?us-ascii?Q?DhcljRHjYkYitWxC/JmHFlTmupgS6Zvz9R/nBL4o7tRw7aqYGdKvQF/MsySv?=
 =?us-ascii?Q?z/L7aNwcgAlvdPMbYCkufE6SftW62mkywhDe3uupJLzIAY1xPYo5zKGLb0Rr?=
 =?us-ascii?Q?d+TrbOda++04gvGT9s+0Rd744yMHJjnNFq5tgSnAVFszm89AHcfOqFWa25+u?=
 =?us-ascii?Q?G8fUcaErgjOGFuEVOi4PZdp6H0mBdyWzJXkQVcNEj/YYzB9T3sBLFH4cnlGp?=
 =?us-ascii?Q?s9NAi5uMxCrV6byCQ9uWdNdxx2xYcgHvdUISwQ9i82VJdIxvBDTVWxpZmwmD?=
 =?us-ascii?Q?BfZPerHQbPSo+t4MfZ1X0mQvKRcAyY/cINoPsKoyMuHqa9k+IAPDbeKppTv+?=
 =?us-ascii?Q?a3rK25ic9Vnt3vzskR43abYiGbm2BXy/KWlg1WdtHTcGuQRkw2XHfLYdJ2b8?=
 =?us-ascii?Q?AtOVo6K3dx07RLArxD1dqJqrrUvt0xCU2pXoKn+eAu2Zf3XDsEXdCH+GEsqg?=
 =?us-ascii?Q?h1spcx/8JgSHu+41lHi2srJgiNWY1Mb2mRTYYKRDMG6PZ9MwH2MnYnHz8mb3?=
 =?us-ascii?Q?hKYEOq3vnAdE1C4L9PUCdItabWsqV+T6FbrvuW1L4dcc/w4ynrlWl9xBKGAS?=
 =?us-ascii?Q?3RDlm8Gw3QE18ji76HDVm3dV4rSrHn5uQyZ0csp6fOgp0nG4Mc94gIFho35E?=
 =?us-ascii?Q?qQzcd+ce56ZMFAfXQi4mfIwjKR0yFQXTW7AkMX6qImWKI8Y83ZXMptGMGA56?=
 =?us-ascii?Q?ynck5OJbOfmzWJn7a0RNdvuSnnRUAT0hXsni3VMoYkaMwGU6VPLEGFfOhrWc?=
 =?us-ascii?Q?JIlI3KwyAqW4ea29w7Nq2Ew=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64518a33-275e-43a1-5d9f-08d9b5ad1a16
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 16:02:12.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgQW9vFthHj2ZCS0UNexO5Te57mpzTbXEwQgJp4znsCldyMxjeiAu785tF1gsYc2HkCVDOVXpG1fkQ+jL6yubA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2978
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Nov 28, 2021 at 12:40:48AM +0300, Alexander Monakov wrote:
> Hello world,
> 
> when lightly testing a dual-socket server with 64-core AMD processors I
> noticed that workloads running on cpu #0 can exhibit significantly worse
> latencies compared to cpu #1 ... cpu #255. Checking SSD response time,
> on cpu #0 I got:
> 
> taskset -c 0 ioping -R /dev/sdf
> 
> --- /dev/sdf (block device 1.75 TiB) ioping statistics ---
> 70.7 k requests completed in 2.97 s, 276.3 MiB read, 23.8 k iops, 93.1 MiB/s
> generated 70.7 k requests in 3.00 s, 276.4 MiB, 23.6 k iops, 92.1 MiB/s
> min/avg/max/mdev = 33.1 us / 41.9 us / 87.9 ms / 452.6 us
> 
> Notice 87.9 millisecond maximum response time, and compare with its
> hyperthread sibing:
> 
> taskset -c 128 ioping -R /dev/sdf
> 
> --- /dev/sdf (block device 1.75 TiB) ioping statistics ---
> 80.5 k requests completed in 2.96 s, 314.5 MiB read, 27.2 k iops, 106.2 MiB/s
> generated 80.5 k requests in 3.00 s, 314.5 MiB, 26.8 k iops, 104.8 MiB/s
> min/avg/max/mdev = 33.2 us / 36.8 us / 89.2 us / 2.00 us
> 
> Of course maximum times themselves vary from run to run, but the general
> picture stays: on cpu #0 I get about three orders of magnitude
> longer latencies. I think this is outside of "latency-sensitive
> workloads might care" territory and closer to "hurts everyone" kind of
> issue, hence I'm reporting it.
> 
> 
> On this machine there's AMD HEST ACPI table that registers 14342 polled
> "generic hardware error sources" (GHES) with poll interval 5 seconds.
> (this seems misdesigned: it will cause cross-socket polling unless the
> OS takes special care to divine which GHES to poll from where)
> 
> Linux setups a timer for each of those individually, so when the machine
> is idle there's approximately 2800 timers per second invoked on cpu #0.
> Plus, there's a secondary issue with timer migration:
> get_nohz_timer_target will attempt to select a non-idle CPU out of 256
> (visiting some CPUs repeatedly if they appear in nested domains), and
> fail. If I help it along by running 'taskset -c 1 yes > /dev/null' or
> disable kernel.timer_migration entirely, it drops maximum latency in the
> above ioping test to 1..10ms range (down to two orders of magnitude from
> three).
> 
> I guess the short answer is that if I don't like it I can boot that
> server with 'ghes_disable=1', but is a proper solution possible? Like
> requiring explicit opt-in to honor polled GHES entries?
>

Hi Alexander,

I believe the large number of GHES structures you have are intended to be used
for the ACPI "GHES_ASSIST" feature. The GHES structures in this case are not
to be used as independent sources. However, this feature is not implemented
yet in Linux, so the kernel does set up these GHES structures as independent
error sources.

One way to avoid the issue is for the firmware to give a large polling
interval in the GHES structures. The kernel will still set up timers for each
structure, but there should be less interference from them. The ACPI spec
seems to allow a polling interval up to 0xFFFFFFFF ms.

Ultimately, I think we'd want the kernel to ignore the GHES structures used
for GHES_ASSIST, and then GHES_ASSIST support can be implemented and used
where appropriate.

I can send a patchset for ignoring the structures. This would be setup for
another set than can fully implement the GHES_ASSIST feature. Would you be
willing to test out that first set to see if it resolves the issue?

Thanks,
Yazen
