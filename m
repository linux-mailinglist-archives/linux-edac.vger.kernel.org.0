Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2310A390A40
	for <lists+linux-edac@lfdr.de>; Tue, 25 May 2021 22:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhEYUFN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 May 2021 16:05:13 -0400
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com ([40.107.92.65]:57441
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233209AbhEYUFF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 May 2021 16:05:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXKDhGeN0flWhBU8hDDy9cAjNqUyQkZzHnGDMv3VYs3b59uZksm/Moq9tEDOqNeNYw8vQk40nIXvweHc7XDAMSYCdNrYzN749lg/qQOnibZDEjCP3EjM794JnwioIrD1vGxLRNSPueocKa7JvP6NZZFzX384i4QcZB8EMmzYsqrzg8s74SEOuurjj3/wCWroOs3tV5CiO/YPgIjxhr1NUd0oQ0dca4uUcVOFQoOMovb0A6q5AizsUzXcO15NZ9bJtZk7Avw8qfOw9usKAhU8jQ5jI57+5rsFARxw6uFecrpOkm4w7og5vRXu1pc7tQ4Ss881K6vHxXnCZgJ6u49swA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsCoOTnO4WOgHLcpwp9t44Krc9Bz9UB5UsFH8i/GcOo=;
 b=R11bvnsmj1u8ocaJRz935A39YHfKDVmGuJnNWE0tDXYXWV3ca3JHE89GDwH0TV7XNEbhZMo4IWPuonbWDtxLvfeihdI+Zt2feNGRoSqsp9qJ7eJn0O5hMLO5L9zU7zvJXJZeSb2pCb7NsPqs4if70+HkGt5IIsBau49GDG0ELYr6tJCt16suVVQ62dWyADQewizJ38LQY96HsGE2BFKtUO+mj1SFIB6YkWwZkBwaWlrZehgvFeWMFSaR6ohmFDbtLC6cgV083K7GnxyHamd4x6In/mT3gGQaXvMAE3tN/I0PcfaAGDx4qdQScahHwKUGBmp0kv5FjcdRmA6SsOcTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsCoOTnO4WOgHLcpwp9t44Krc9Bz9UB5UsFH8i/GcOo=;
 b=v7rMOcFngOoa2kR3at9quKn6P36wAaB/QYNnHmIT9RLOeV/juMiIS4wfyGO+V0p//fGJVZ+Oyc9zzgzY2ZOnORmmCJxb5R+iSQihppvjPvGvWkPiBlD6cJza8uw+s8nIxnYZEvdVVNExDncddVXRn43oQfGSAC5PLvdFuNKyXlQ=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0212.namprd12.prod.outlook.com (2603:10b6:405:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 20:03:34 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::453f:6e2a:468d:ad6e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::453f:6e2a:468d:ad6e%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 20:03:34 +0000
Date:   Tue, 25 May 2021 16:03:27 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "M K, Muralidhara" <Muralidhara.MK@amd.com>
Subject: Re: [PATCH 1/3] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types.
Message-ID: <20210525200327.GA8891@aus-x-yghannam.amd.com>
References: <20210511152538.148084-1-nchatrad@amd.com>
 <YJq+ca+kJ4cRl5B8@zn.tnic>
 <DM6PR12MB4388D2F749166A72974718C6E8269@DM6PR12MB4388.namprd12.prod.outlook.com>
 <YK07xEG4567yv8vl@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK07xEG4567yv8vl@zn.tnic>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:408:f4::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.84.11) by BN9PR03CA0159.namprd03.prod.outlook.com (2603:10b6:408:f4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 20:03:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c426c038-9a8f-4fe1-a6f1-08d91fb82cf3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0212C40DF8124202954A905DF8259@BN6PR1201MB0212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cKwfmGUWDb/8N5bou5g2bNu1IzTG2E0DZvmaMg8IqYKRJUXxLKc8yD9U8rR3U2jw3ZAmsYrM4A/4t057CgIaWJuiW6H8+UsCcmDexsNadkeVoLl/WYcSB4kPQg9UnIV+WKIkEO7lc+r8LKdR9h5rDUTNt9XKchSn68UOARSNJuAgrc8Qu9eENDszMws+Sx3vVeqfxmQnQbeI4tdHOlzGeMqD8gwIgz6Wvrt2dCni2L9ApbVLgUTGQktjDi+GQjAe1x7VnnvKWRi3m04lhQFIdP1zpcESeUjDq/jt+btpHR9i/65W6IJMmztTnekbYGuex97/k52z+jw1/F/xcslR9DdCZRvn9uhbOwXvAflVhblqc+G0LPyCwdwzh9t6TcpMOEffvjzkd9J9osBYymP64Z4rQACGqw5RS5J9LB0aau0ByaxpRpot2C7L621TD+3k6hC4l/NXtoNKR715intaROfaUqsnmGTkzUCqIHkOeGxva6GPzEvDtFV/xJnb2GGIms/nVF2H4wT9jNBZ7sSpjhU0iouX4n7pa7zjvBgEz/z0yO23oolFik6EJu9ex7d14a4/Jr6dH0HHZU2HpgMoRrNW6cHb8ogi9ya3XgWuR11AOBFEWJsQO+Z3jIQ1O/hFV0vGkDduEWvm5YWpGHJXJMAb7phRJOQkIfYP9tNBOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(7696005)(83380400001)(55016002)(44832011)(52116002)(66946007)(8676002)(8936002)(26005)(66556008)(16526019)(66476007)(186003)(4326008)(6916009)(38100700002)(5660300002)(4744005)(1076003)(33656002)(6666004)(478600001)(86362001)(316002)(38350700002)(956004)(54906003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3rDgOUxCl+kLHRqw2mnFKSscw8PaqrQkV8Y+ITtUxGMN1mQKm8ZdJli4EQri?=
 =?us-ascii?Q?imIXy/pYhJZIjCyECtC9ywMYM4QOzlYTJUXBoEm4g5dFTUfDbqRmPRu9xNng?=
 =?us-ascii?Q?+P9c16iRzLB0xFTTzAzUClWsK8z/4xEzcO3TpVsso40/fx/RXW3Yt7R6bnAG?=
 =?us-ascii?Q?SrSSh8+80O6e9zUGqJDjKrtlwmQOOtCJdGqD2/ekVQ/4ucAlL6p8WWxDWUaC?=
 =?us-ascii?Q?SX/3n+ouJa49YeOfaD5efm9tgrvQjvqe81JFGANK+Cl5leVdlZI4udBGYT4k?=
 =?us-ascii?Q?IthOIaIPe0J3pKNrvSWnNYUCe6r68VVOj6Eu9KfwPQAAPZmSLHcTpquOmt3p?=
 =?us-ascii?Q?wG1DbONofQwcGH90ptArFW31j9roxlX2nAIQTVa0B7xwlV20lNOt0rHLIDbq?=
 =?us-ascii?Q?/CILshJaAJzSRCcKmULb6r/8QLdxFcK7zTvJgfRFbIEJIrmwAPj9ymWwB0hY?=
 =?us-ascii?Q?FL8ZTrrN/r64rXDEahI31/VGNx/odOBYRM2aJT3yFT4r5PXydkeCCOozh/rV?=
 =?us-ascii?Q?NgMMN+7PIxjn0SRJiBLn8nTRHbb6NwJFSRfn9ayneVI6inGET+Qg1PNuEDUx?=
 =?us-ascii?Q?i0YpIE3Jnce6W1Zi825eezNIp9lA/QKmub1cWlU8RhmJXRsoIeb0i5gLmCo+?=
 =?us-ascii?Q?Ut02FWM0MsiedSn+QxKWkkpCcZKPSbfHIXOXt9LcQcLTbP3aK2a7uenNht7x?=
 =?us-ascii?Q?RfERMJxIA5oa3e1n5gVELU3Pp1WbDnWaY5Glmhm1g+sV5NxrjHXeXo/7T1i3?=
 =?us-ascii?Q?V4PDkWC+qPosieGwV0dGED6D+gI/arKLqxI+zFbztgJRERU9WwsH6vBRxzvE?=
 =?us-ascii?Q?69374GnYomarqHA7jJc0Iv/3vd8QOqxC3q8aIpE8HRvvFqjbyznlsEMIr/+G?=
 =?us-ascii?Q?zyT+LxfVjaDRjE8FnIPAEIB84A8/S4vSdGzZkUqXxTU6GTX82T7hm/h5LpCi?=
 =?us-ascii?Q?z1pQRPIw7UtZnB1f8/EcBVemC+skk0Haka0/5rEvCDe3oecdF+7cA7GV8371?=
 =?us-ascii?Q?A5Ym95mp+5MeZmtk5u5VS+/IRw4OKL9cGJmaxb9yRZEYjGVolggQv+eqF+t+?=
 =?us-ascii?Q?i/nFUS9EDMv+wq4zE2u8rJvROQEjSsOcKK2LGB2hPllmpwX7CcqXarpNdgJR?=
 =?us-ascii?Q?DPbftGsS0QRPyIBy8jsomTLBdoY8uHChRwzGWjucSG4j1j2Wu2lrmsel5Cc8?=
 =?us-ascii?Q?8GNgfgEtB9zQHzHr4f680vuEs4oJFleQl3fJ+9GHLou25UEjkj66HHha8QfL?=
 =?us-ascii?Q?Zu0rQ9p9496xaDvgILMsc0G7Fl08AcEx1eNQJa5kCNDR/r46begTerSTTf+M?=
 =?us-ascii?Q?whOkUwmIAS51wDDUv69zz+RK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c426c038-9a8f-4fe1-a6f1-08d91fb82cf3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 20:03:33.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzwctDTICEGRnYbD4zEw1qUhL6iynJLZfiOYMoobyJK+bI/egatAO236V1JyxFEiP6AcM4Titf2Zx4bet4FuWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0212
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 25, 2021 at 08:02:44PM +0200, Borislav Petkov wrote:
> On Mon, May 24, 2021 at 04:41:25PM +0000, Chatradhi, Naveen Krishna wrote:
> > [naveenk:] There is a possibility for a heterogenous system with both
> > the SMCA_UMC and SMCA_UMC_V2 variant of controllers to exist.
> 
> Wait, what? You can have systems with *both* UMCs in the same coherent
> fabric and thus the OS can see UMCs of both types on the same system?
>

Yep, that's right. The UMCs are the only case of this so far and in the
foreseeable future. Though we may be moving towards more cases like
this.

Thanks,
Yazen
