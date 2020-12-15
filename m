Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1232DB0CF
	for <lists+linux-edac@lfdr.de>; Tue, 15 Dec 2020 17:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgLOQCs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Dec 2020 11:02:48 -0500
Received: from mail-dm6nam08on2048.outbound.protection.outlook.com ([40.107.102.48]:35424
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730744AbgLOQCb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Dec 2020 11:02:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfVEeemUdjWYV4UHCdpvVbkOijncNUuxiRm2kyICrotImMa+biX/KQCZXoqLjO/GAidlFEMegJVY9mGJKlmbNMKcDM2sano7l35F+zS3aPuU2zBccI7Y6PJTFdV43UGDJff9LQbJa0QJC72ix6YWnKFw20FDhiquz0VddVgPfORb4ECq02L1arm4KjeRETH5DVjOTuYVQe884K0iWTWO2GimGd+R9oJF3hfioxQMckWIEvmpGXy+GS2wqgG8sx0JK41/2zAsMADrMHVaPm6NjaZuBaA156+gfyFJcIz1dTByCgmPAo/QS+NwuJV9O29Yy1YqjohWzsVrP1X1zEkkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4xyKNs0GxePMtB/HNGfCBKO36IWyo4y/7nsJYGSTdQ=;
 b=neMQXTQ1Qb2CPMwP0dbULq9FQxBOYchWWs437URCa0uCGzw3N4zAYNP2cEtTcENiP59G86jCqnYhiGVnuEPOouUPANQYJpnNvkCx+MhDYbqFdPqkyi44+Bhi42AdHZW03f/ljYyxLJRvs4BIxrrFQLx4qXwaY/JdWk2Qb3miA2kcaj4j44TWks6CmqiRobpvqVzlUrL53tJ+zrSozINpaRt3fuSWlzjjiup/YShofTIWKjABxnv8nVKufErLVfxdud0z3qEGFzQybaStpgEV8TMJQkxFZeFqP5Zofeuq6pyW38LgSzDEJ8uXhmCgpHjHK8Mmu8fjdq9Pt0I0S9NLAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4xyKNs0GxePMtB/HNGfCBKO36IWyo4y/7nsJYGSTdQ=;
 b=dn1XM/MZQR6Z+OXtdY5eoSpqYmmNRB9Pf78+iXk8celvsucFxGfPA57DQljyMmFSP7JjDd3HWD5nxCuLu0K8nHU61HP282MGKlN8GijI2K7qCgeqvsWiYcjBwstTtbzQj4mRtA7PjyVoiI0DqivnatFAYtNUYLHd6tOtc0aI3bQ=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN7PR12MB2595.namprd12.prod.outlook.com (2603:10b6:408:30::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Tue, 15 Dec
 2020 16:01:38 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d%5]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 16:01:37 +0000
Date:   Tue, 15 Dec 2020 10:01:30 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] EDAC/amd64: Merge sysfs debugging attributes setup
 code
Message-ID: <20201215160130.GA2122783@yaz-nikka.amd.com>
References: <20201215110517.5215-1-bp@alien8.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215110517.5215-1-bp@alien8.de>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM5PR19CA0033.namprd19.prod.outlook.com
 (2603:10b6:3:9a::19) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by DM5PR19CA0033.namprd19.prod.outlook.com (2603:10b6:3:9a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 16:01:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b54de71-ab70-4569-344d-08d8a112b456
X-MS-TrafficTypeDiagnostic: BN7PR12MB2595:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2595E4361D738F31F6730EACF8C60@BN7PR12MB2595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRhKsrF+IS3Af5/M7i9Hx5t4o/oez72OuIuRFdXvyxgLZ+iPxBf5asIC/3viDA1Wih1yHcnAHWisOojHyNoDW4nhyU21HBno8Bw4NmBfs4O2RfXCYmj/3escmKpllY1R7ex/v7OLN3c6nY2sL0qa8hehD4PtGzV7Tg1wGMKVs/kpV9tyx47vitG9wEImxGHGEdzey0EWSlAZNsW9+0emlO8Abo/y3O1Qyla7vlbhP2pO/sgaqX5wXbro+6kmd5v+RniNbYTO+Ic0SnFlMjQHDBOtCl5dWYG77gsTabAmWEw+SrmlSBoyjKqs3kIiFYMFbqnwZcjzId3S0oxTQAV0pkkWwK2juUkzOCcQlBMhl7JvlblNAaG1Vbh27o7PyOYx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(26005)(5660300002)(508600001)(66946007)(1076003)(33656002)(16526019)(6916009)(4744005)(55016002)(54906003)(8936002)(2906002)(52116002)(86362001)(186003)(44832011)(34490700003)(956004)(7696005)(4326008)(66556008)(8676002)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/pl/Rtr2NtonOMb9tIgQTd4GTthIjrhiA9CFERb72rT6I2trejpZG9Ty+eVL?=
 =?us-ascii?Q?9I4JWk3UwHj71Y/94U/TQQfSSNbarIgPmxOo1gZnj9HOn5lWmQw2ya3yg3QO?=
 =?us-ascii?Q?2lUSn97ySGwMPF3t1FRa2lm+NSK5zy1+digq7LJxx+G3eHTSdxTXZ54bzNYE?=
 =?us-ascii?Q?p5wz9YOjT6VwJThyErR0lsrKFJw1FTgoxK+hYpsvnv3kT5NHm/aYLZv/OTsz?=
 =?us-ascii?Q?OAelZdZym2XosOBSdhCjI0OOGsG6V3IVUKawOKTdNYwoQhmBKpGEZWAlOsDo?=
 =?us-ascii?Q?EWR9zWNKl2v/5wY7dcQ6oDX/lWR+nafYZTIkBVP8suv1cyubbqDpU5QVqMd4?=
 =?us-ascii?Q?EbOCkBT1Bvqy6/R4d7eLfQRlvGPu21ohsb2BA9YNpxQjgUg7XbvM6el/Xzun?=
 =?us-ascii?Q?9NP+E/yY0hNK2D4k5qwtjtc6PgXUUgOxszk7L7s82shgmxEP3IQE0HfpL+Ld?=
 =?us-ascii?Q?r6GK6JLdhzJP5Pd+fFSU93v5VxWK1rfQgn+bhkV0I6dODetfcGyiUOTGSTa3?=
 =?us-ascii?Q?zaBBpRhwYePzXI92FPD0uvRuH6/LSErQ3n0hhMR0tm+EzUDQzbQEckAvTlga?=
 =?us-ascii?Q?Ka9LGPpKbOpjmxcwdTpN8TRosVaPB8zoT63qtXSk2YKjjMZgiOncXmErhsAl?=
 =?us-ascii?Q?NYJ6gMh2VSYoFwgJyvqnQ06KjTpBANvFCg2kkw4dGmmuH7nIpn5cxO4tKXA/?=
 =?us-ascii?Q?+fon+FDG34WL1kDBKMIyhsiK/POZe8mrsDomZwGnPebAhsKOZfrTQeaQitb7?=
 =?us-ascii?Q?OGbbnH/GzbScGaCo+znlR57qIoz9YBNae0Q1v1VglcQDb6DBiDxX/cOfNoq1?=
 =?us-ascii?Q?wFf/OvIn/i4clfgOxAuqfKbfpvX3K5PI8F7hmhrWawLbmzCqtMvEnjPDNJhz?=
 =?us-ascii?Q?C4ZF3G/5em0VMkILb2QdRKVX5XNTbjougkahfIeEQF16zK8Ph+hRJjb67mK+?=
 =?us-ascii?Q?FoEFdCyV0FpkL1ISuZNOExJvpOXzEUTRjepYsqm7XEyY/yEnAseLq9EC5LYk?=
 =?us-ascii?Q?Wj3s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 16:01:37.9117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b54de71-ab70-4569-344d-08d8a112b456
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqnW7vz0Q/vOSXlRwgZRmbyiQxAyIJFmVu179fn4fDDae02mugEXf4ftBf9Q6E7Y4j5gAdf2VsOyCC9wIQl0RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2595
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 15, 2020 at 12:05:16PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> There's no need for them to be in a separate file so merge them into the
> main driver compilation unit like the other EDAC drivers do.
> 
> Drop now-unneeded function export, make the function static and shorten
> static function names.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
