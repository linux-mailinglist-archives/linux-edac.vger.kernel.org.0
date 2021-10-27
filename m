Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6D43D6A2
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 00:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbhJ0WgF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Oct 2021 18:36:05 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:62369
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229822AbhJ0WfO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Oct 2021 18:35:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYKnOmbTsPblfiAi5cha4SPDkqX1JdRsYHUZvGaIciN1ZDyy9bzAO6UyyVpGc2CZ8i6dHuatXF7FQn91QCNf9Cvd0Ado5lZnMO22gWLcx2iM7PdnDYOVONIpL9uw4h3Pd9+Ls5GWkIX0USD8muYjWfWpKLwrPqzUeeaHPpm3zwu8oCt0rgcX6h9PtolNxfivuwxDEA6zI1NGzE74l+Zy2f7zHeIQN8vmtW33Z9zvozhkSbCJoJIU2Vfx+jnQVq6joZx+v7oi42bMz8nteF2CvAtwZb6CGZCfpt2PBUKWH42GYytN8y0sDYwhyc8Z7w3HQ0JL/a6hu0hQLhdafdy1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Y7pjGPkHiP/H9DPuMFulSPHlr2UfnGU5T6w9crP13o=;
 b=P9gSyMdf8I5UWivH1HYsrnB+KoJ/FklzzlnVTkFB1wGGifaiU36d7tKX6vcFkS+7IKedhnOfUXVF1xKQG6dS5hAAQI4OPmKYuzlTG1tvzHDtxQpDgjksng8rjmE+y+w8AWEjJIpllHIZmnRztQKF9EDXnECPMFMxEja3pISsE4LHo6drHax8znreTtVayuoB/XytwVc3Oya8Xn3nDuz2bTtkP9QVQXGGw7ShyyCoQtXyCFBrl0C4xNo6ugcwi4a3QLFzs2kgYkvZTT6OGGIzVjcrYQYWCuaXEKe2Haf/MzH/jJJm+rfL4OT8rxNiaq1UUrMqVvtUzxGFfTIO3qYBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y7pjGPkHiP/H9DPuMFulSPHlr2UfnGU5T6w9crP13o=;
 b=xC6/jcojPn5zTSkdXhYf0bQNaBUg5NKfmdvIQI5s5ANXQpDdhIWaUeUYepELL5zRBnB7ABcPpjMe5wtc1k6RQfU4j88M022wrBswVIttozzMZTGRbfRDugxoGwa4L/RAiMs7B9EgCNyBBnint0wPQ8AQHUU/yoipuGcLwLkWbYQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1314.namprd12.prod.outlook.com (2603:10b6:404:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 27 Oct
 2021 22:32:45 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e%7]) with mapi id 15.20.4608.018; Wed, 27 Oct 2021
 22:32:45 +0000
Date:   Wed, 27 Oct 2021 22:32:36 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v5 5/5] EDAC/amd64: Enumerate memory on Aldebaran GPU
 nodes
Message-ID: <YXnThJnUuWP6Ou/D@yaz-ubuntu>
References: <20211025145018.29985-1-nchatrad@amd.com>
 <20211025145018.29985-6-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025145018.29985-6-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:23a::17) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by MN2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:23a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 22:32:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72f68215-4258-444d-da21-08d99999b244
X-MS-TrafficTypeDiagnostic: BN6PR12MB1314:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1314C6AAD68FD095E0FE1344F8859@BN6PR12MB1314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0xCgHD2TDOzlwib2rAB6bUivzY7QFrOHP/yZ6gNFVg94qndkNWlDq+qbRVpWnefXn1HwNER6yTEGSYMoJtzIcXwHNpECrlLNMkI90INE9C/VJAm8ziRPWJI2MoAUxZx82VTGd2ZBwz14tRIsW7HjIeU3jO5dynq3PzC6MFcDJVFGhLgT4n1sSW52kWl0ozaTclTSAAVQFzLJAhyknNaBfs6JYkvouaA0zZ3v74AkHkiOnDlbDsk2AkX4PzbSPNl04iD8vccZBrX3Rs6Dz00Abalch1upwhyBJ3kQqy4GleLy8wJKF/w9Y/xg02O6hY6uKbffsjA1+TJu2qZcgqspeGM4gLx+K7h2vY5VzxR/Bokf+slXy+tJAgPVfijk2kSoRJzisZSIjxksiG+FTDQIaWnaLHhJ/Zcb6/JfQmLvh0uVjoctM98/2ci30XKyI0CORXxqK/9fxt8dMHTEEwPwJZFtxkVQX8Nnh/66+cl84Kn73+C7/ttBYEPdSaG/9nHEO7H9nbeHMNy5MfcKRIE+zBkBAPMHdrlYcPmQhd1bFFZ3wWE5eu+NxfFCeiloGLl1f+A0pySR5HFlP38RTjFe2pJ/0PdTAv7Nl8RaO/DtdSspWgHYIG9lHAVjgtaNKhgF6OIgofbmXG4rg6VaINtXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(55016002)(44832011)(6636002)(316002)(4326008)(956004)(6666004)(2906002)(5660300002)(26005)(186003)(66946007)(508600001)(66476007)(66556008)(6862004)(8676002)(8936002)(6496006)(33716001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wzt4uEcJxZHHp/mnpzSfPqEgTAHRepJIS43xU8CPnJ76TKLsH9acY6PegMGm?=
 =?us-ascii?Q?p4HFOKF4MBMerdQXgSS9he3HKIOSUyjTDngTq3n/t/4TPNwI+ZJ6x4tK+i5B?=
 =?us-ascii?Q?P7fYfmK46r1YHKubDLMjxmVICkyWaZZxkSc0ewJTtd4iFf2tMB5+jCG2mYx+?=
 =?us-ascii?Q?86Dj31FWHE3NV7tJRy8NU/Ftxqo7oy+bdS5xHUFpBHHGZSE1HU1CIvZeU9DQ?=
 =?us-ascii?Q?msQQern2+66l48hOPnpBcEpesQqqz3OYtkhJkmBx0/5UdYiuCN7OdGln4Egw?=
 =?us-ascii?Q?Vp6kGXhSDs55va1orBiizyCOKoZr/bdgUnZT3eo3ungePD57r+FcJ2zpbUyg?=
 =?us-ascii?Q?na2iJSrT9sHnPqldvDzDWuf+XqemuoUWhXMllKJNcm0tzaMPXL07uevMb3gq?=
 =?us-ascii?Q?4xKq3o998X+6rvIzOtMfLGVj9559g8AADqCaR2rDuOIeUhMkXMBrPFDaQAZc?=
 =?us-ascii?Q?88OC+XzAHhsmrAT0pJLh0tkdavi05mz3cYoMrDdbIOOc/LFChDKcvNG9GdDP?=
 =?us-ascii?Q?XekWa4VNDXR1cfRLWn8hSfJdZ9uWk4bK7KvsqNKcO2XXCMBVwM4rxlB5IAtu?=
 =?us-ascii?Q?IjUijkh1Sxxlo5bFfK+ShICBNfVRr9jEbFWS5J5A+nmA/dXh4OuFqsBUdhcp?=
 =?us-ascii?Q?w2KlD+VQNqbR8imzXYBXdA5R8pHMYb1KIwFDAXoYKYO70mquGmUiMB/qsfV+?=
 =?us-ascii?Q?Zo9GiZ7lmmKpXnZK4ptanUOvzvNFL9ND58K2NGC5R0mX+/DlrsZuoPxSq75E?=
 =?us-ascii?Q?7S2+ixXMRJ5WCseR9DqPw6cCjGNYoeQOOJVvNX/cSDo/BnW0lEfOwiIIu17y?=
 =?us-ascii?Q?nXx1nWSQLDYCAQN6YFAcQwujNnNS1q0hbyG46auAQ0Njz8RbDTHT4F3RA7Rv?=
 =?us-ascii?Q?aKkmWOZ3A4S7jP58Jh3+BmnbQp2fEQyaKgyUcJeJmJ4WIw1eaaYx0r++dDny?=
 =?us-ascii?Q?zA2nc6P3CqZ2n/hcPXa1FLqW4iFmZnFGRkBqH9nuZ9b4pfR74hzM15F1Ol2c?=
 =?us-ascii?Q?RgijZ9hv+VQ67SQbow37v+eJ9zw1JhFqctbWjTOQxsD4+OWwze5su5brLVoJ?=
 =?us-ascii?Q?Yqp7OwPxuacwGjAnPf/QO6lRWwim30LtKiZpXRUaNLGIfK15hUOrtDJiyXnW?=
 =?us-ascii?Q?9v7wCCn4retsCUt3A/3v4ZS16/3TpQgZtaSL6jfoo5hwjilbhmGMtDKS6C29?=
 =?us-ascii?Q?ztKVOeC+dbcNm5Ku8cnMHOsKFG6QxsiDKLlAKAGq3k5T09j3e1VPnI1vN72M?=
 =?us-ascii?Q?36/0A0Jar6GRUn+iPl4jAn0aquNoSyhvDe7GUGiuGuX2jpTCssih9ty/GJzJ?=
 =?us-ascii?Q?tFm11Uy9p0qsifeInUaeBxXvBBG1yxLeFe8BukEFJLiPRujqmF4ddOzZ6YCU?=
 =?us-ascii?Q?c88L1ixD+TOe2UbuDqI54iKDE0ZkT6PyvQOdG/NKU8ZvhrmOWa8VS6J7jgDV?=
 =?us-ascii?Q?zzw0E5tiV/fq2U36pNW6LJ9dSt2OaV6pGiJhno8tkhH5XBdK1wCw35g1vZyd?=
 =?us-ascii?Q?AwjQ6PuHSgW41qcwqYpqlZ+V4MfhyMa1qbgO1rDIueb2XXJLBMnJJo3s0ccB?=
 =?us-ascii?Q?EtWZ2QnHouKkF5mZdVOFP08/pIRI0fjEfvoTAcQpDYVgenEFGuWYRsmp+LR3?=
 =?us-ascii?Q?QAkxWp5HLWpDeaBG0/AQosg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f68215-4258-444d-da21-08d99999b244
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 22:32:45.1597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAmYOHuWD9r8gCpkEpNlRii+w4ptVrs4/fhBny/wV1okC1xghD2kdLUdqpHZyGASNtx9qe8HqRoox/mlQ+hZEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1314
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 25, 2021 at 08:20:18PM +0530, Naveen Krishna Chatradhi wrote:
...
> @@ -3726,10 +3944,21 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>  			pvt->ops = &family_types[F17_M70H_CPUS].ops;
>  			pvt->fam_type->ctl_name = "F19h_M20h";
>  			break;
> +		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
> +			if (pvt->mc_node_id >= amd_cpu_node_count()) {
> +				pvt->fam_type = &family_types[ALDEBARAN_GPUS];
> +				pvt->ops = &family_types[ALDEBARAN_GPUS].ops;
> +				pvt->is_gpu = true;
> +			} else {
> +				pvt->fam_type = &family_types[F19_CPUS];
> +				pvt->ops = &family_types[F19_CPUS].ops;
> +				family_types[F19_CPUS].ctl_name = "F19h_M30h";
> +			}
> +		} else {
> +			pvt->fam_type	= &family_types[F19_CPUS];
> +			pvt->ops	= &family_types[F19_CPUS].ops;
> +			family_types[F19_CPUS].ctl_name = "F19h";
>  		}
> -		pvt->fam_type	= &family_types[F19_CPUS];
> -		pvt->ops	= &family_types[F19_CPUS].ops;
> -		family_types[F19_CPUS].ctl_name = "F19h";
>  		break;
>  

Why move these lines into the else clause above?

Thanks,
Yazen
