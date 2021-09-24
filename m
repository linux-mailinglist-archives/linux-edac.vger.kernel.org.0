Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B3F417BFA
	for <lists+linux-edac@lfdr.de>; Fri, 24 Sep 2021 21:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348236AbhIXTzE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Sep 2021 15:55:04 -0400
Received: from mail-bn8nam11on2069.outbound.protection.outlook.com ([40.107.236.69]:17569
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348240AbhIXTy6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 24 Sep 2021 15:54:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqrWCAeVV15VAdiB8SNTQIVh4J2cAniBFYxzEVv3gz+yTFB2FMhsrqR7BjGEXuq2haEQgw9ho79SkvjejYI+vhxy9625FbBtCJ0+nVII4sU1ZnO+4/y+ayfYi4OvVI8Up1Qtp6U9O0sEcSJRVI8K7mmsqnZgTo9B+FWfi82FiSbR5pMjwas2nOZGrvkM6PY4k3cqdClZJqp0JqfKrBnNCiitMVhLSYg92toxIF6ktQZvzWB2YhsXj9/9O29M1B44xWAil1SJICSh+1Rlgu36zSIJIUaSzCn7HEsM4VbixI/zi+Mu9Mh5/HD0bozi2CQ78YlG2JRiAgVmpZFStzQ83g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RqS+9EU+z0WR9EGxQEsn+4rQdssY1JoVSPQLSNBvhbo=;
 b=JuV8/xAQwKAV+K0DHqqTM9pBw9leh/Xaq0sDkRxZKC4kV+Mfh+WbXSe0khTG7o3bgh9gdB48iC+9Y8xGndAXsSl/9zYYmvkxIQf3BMQjrKylE9ac2glBO3T2DeZgBXOVz1+GCznHFNWBCrSjLTqsUZ73Pg0VVJnRCbu5vNJy+Nlk05llG42irNXyJlMS233ospTnlAoQfGsKBpUzmAlh6P0/FnSFMKZ8D+AexCYuKeenwfYYAO0MxySIs+tDX8LxiLZGV8OYP7VwlpHZXG0WvzfjOJ1l3LoUpjhYZxw5+1PU+T2bk1GcdAxJzQA3i4yQRgd6zNDjirSVpAw97a3HWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqS+9EU+z0WR9EGxQEsn+4rQdssY1JoVSPQLSNBvhbo=;
 b=x+Nm9kaCr23rD5Lm0hsisAnHv9kVU2elhL8yOwfC6SZKfw7GRMdkGvdYfTvt9qq5Y3bDhxu4Fm2fmFAjdiFxqa6Q9cNyhFg/Pb8O0e7yRsTOYNU4YNxs88hwjQXhayewHTqUUTL+oPsO8uREY78EALZfmOldJE9UlJY/CtOSMI8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3283.namprd12.prod.outlook.com (2603:10b6:408:9f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 19:53:19 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958%4]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 19:53:19 +0000
Date:   Fri, 24 Sep 2021 19:53:08 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Mukul Joshi <mukul.joshi@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCHv4 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Message-ID: <YU4spAoQCfwxvnET@yaz-ubuntu>
References: <20210922193620.15925-1-mukul.joshi@amd.com>
 <20210923220434.25245-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923220434.25245-1-mukul.joshi@amd.com>
X-ClientProxiedBy: BN9PR03CA0936.namprd03.prod.outlook.com
 (2603:10b6:408:108::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BN9PR03CA0936.namprd03.prod.outlook.com (2603:10b6:408:108::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Fri, 24 Sep 2021 19:53:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55c002a4-f7af-4f48-e93e-08d97f94f536
X-MS-TrafficTypeDiagnostic: BN8PR12MB3283:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3283AC8D1F8AD789F05E9B48F8A49@BN8PR12MB3283.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGIbXVV/iBX1pPx9eaMOXOb3Y5Nf90qIwqpQgxLJcjSkJdkoc4CDdNkld5Oq2n290MlHg1G0T16+Ll3UgCMVYRkM+kIVL7WNuqb3f+ewElasAmdbEyDymTiwGBRSRKD/w73Sag9KKIuMjodNwZ52nFa+wy8JeVv/FYlEIMiG8qot6h0T8tMlVYrAhJyCv1bvYHz2lvQBzfgobc4uc+j274bo7U6Ri4Qkmr15vsUSys5/deMRtgONQBA4iZQArH7Izd5+UnyEReMH+jMKaw10/RT6GkfZ5NUUf7cC5R1NJHJVHk23LC4O9JAR8HbNaKnXEhbFAjyn8IVuHbuP0FXRys3JuB7JTI23Q0YHqUbwB143VP4DeSrNYuV8Bks+gE89yROAS8B4hEs68Ywhk78giQuJgdO3IJpGHhZDlTpL0qttRl25aF0hS0BrFXxrmNjHWlXsv+G2FI8kuIrTUAvAz6mOdGAB+1msR4EKrp/tEt+sKxFLWxkZVAHyLvld8CDzkWza68xe8x+J/zAMqGSJUI9Xl+4iXK6piMGivHsbXdSGiskFRSO/A+tvwM7FKCpCKugy7k+MUnvera36uz5GXPkS6tNH2pK+p05yuk09jgUDuB2fcQLzvXFJbQuEmrZb7V4C3mVayvsMjKrrXC+z+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(86362001)(6636002)(4326008)(33716001)(6666004)(6862004)(956004)(2906002)(26005)(8936002)(5660300002)(8676002)(66946007)(66556008)(38100700002)(66476007)(6496006)(316002)(4744005)(55016002)(9686003)(508600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jQuRNwDdMSYq9zEuwX/dEQPW+y8QF2c+BQZ/z7j9inScmogLD24lic+ySJVK?=
 =?us-ascii?Q?oTMbUG8+gbT9Elzvr63mVrT172VMSS1SYY/3kRlkrE0hTjc3cdr3RoxROYWR?=
 =?us-ascii?Q?8Nc/Xh+1qywnx7mSRVaZTrhPMzEIlltQj0+6QhIYfWuB4p2NqGbI4BGLRmm7?=
 =?us-ascii?Q?vtM8KozzWVeylh+RE4OPfEXLGcfF2SEU24os/tWWRjKWWxUIUwROgBFkFwaI?=
 =?us-ascii?Q?I7gJgyhkTWzF6tCFB5SkVlDeEbHcjbFZdc8WIn81s6zmv9CVtn563/ztkAEd?=
 =?us-ascii?Q?MySbXMjcB0y7gBnfSYDe3deQARlxu50OBT+O4wS86N2eCCSEkBXgVnFisz9r?=
 =?us-ascii?Q?Nf7H1ipXiW+ZY83FmymFJAYJLg/8IwOOqcwBKgblFpxIU+vVOhZ+dvpC4CM6?=
 =?us-ascii?Q?FDI6izCg8I+UttOy/wqehnhR6g6+mt09cFi93NzYbn6ySiA8VSaZEZ9nXzs6?=
 =?us-ascii?Q?V/HCLJxr0kw4w49ebR4cRJ6IfsTUaUj1XJVV/FS9JIsTFWoRVBbfIqCJ/Rn6?=
 =?us-ascii?Q?SI2PKnZ6Zn5l50Bcpg740HL5VD0JH3ifbLiWW6qT/vbPm6Sd8OX/he3d21Js?=
 =?us-ascii?Q?zl/BgE+jh6qrtkze5D+ODM7sNXAQzl9wRwkN7HroRb+EbpG4b5Yx3ZVObEhH?=
 =?us-ascii?Q?9LtP1JnD3kBjIf7IXKShe/7gKDyiO63KRc+qjorYHz3tNR/uw8CyQXheAW8y?=
 =?us-ascii?Q?UbNqT+1vsi12cS4UG0X8rWOi3lk8yim2lyh9K8j+5eoXQgqGFHJ2bjG7yJtp?=
 =?us-ascii?Q?DDyVByRZ7ZKnSvi5DYt3hJdZs9zutcCT1rinmXhAo8H/Nj+L8XhWDGNCd0n9?=
 =?us-ascii?Q?aLWaGDbTSjuVSJsnuqPYv7R8/lQW0M8w6KBYZYUvg+emHzy6pSMrkaZ3Bx9Q?=
 =?us-ascii?Q?ZXJPWFflB4Ydo5CUxR1OuRfYyTgx2NYLlW2mocv+EuPAprsrpXmAqAlNP/NQ?=
 =?us-ascii?Q?3zzgQdj1fM7yE2d5AEaf3kmvzxItpcCiGwsw1fYRdLIco9L/laIQd3DHNiBO?=
 =?us-ascii?Q?6h/KZEiIIKBbbZ5fkGiVcCprDVFUdPbXSNqoQYv2+nzA8spNNykW5wVt4TVx?=
 =?us-ascii?Q?6ns+t3qdCdgA1gSBRU43SwIX6zjNWExj6Zh+68r814WFWXWxd/qHLqg14Zby?=
 =?us-ascii?Q?dFiB32rjFCn1B8bPg94Sv6ZK1PioKfDPDqJ2/ltowuo/PxcsLV6UbcNPgmqu?=
 =?us-ascii?Q?hNm5CxNOlnPPm/rYxjBpb4hBGHBm0/y0HAePaKbzLdh4X8wuQ+rajuIqvZcG?=
 =?us-ascii?Q?62e7JDBjv3p98nC5Z0TU+XmjudBP3DLorFnQ7DIcAyqAF54g5ax+GJwT/XDk?=
 =?us-ascii?Q?VTY5HYNqFVjRbJRWP6OEqBjK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c002a4-f7af-4f48-e93e-08d97f94f536
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:53:19.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QztRHHcxQolsY5e59VP7EPQVLOGZGmyjBqHD/xIS9wdfw7dUqbox1nlrauAfwIgx7Ky7PwmHyDa2laklq5N9OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3283
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 23, 2021 at 06:04:34PM -0400, Mukul Joshi wrote:
> On Aldebaran, GPU driver will handle bad page retirement
> for GPU memory even though UMC is host managed. As a result,
> register a bad page retirement handler on the mce notifier
> chain to retire bad pages on Aldebaran.
> 
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---

This patch looks good to me overall.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
