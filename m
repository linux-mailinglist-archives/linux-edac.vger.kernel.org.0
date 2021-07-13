Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6903C73E2
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jul 2021 18:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhGMQNS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Jul 2021 12:13:18 -0400
Received: from mail-bn1nam07on2062.outbound.protection.outlook.com ([40.107.212.62]:16512
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229913AbhGMQNR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 13 Jul 2021 12:13:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HR8ZMRFQkt6qgv40t3iR/GEI299mFeby82KYjwcHSqCzPLWxqZXtmxrH9Ibq9gq8Xwc8n0zt9+EYYjYi5xUNNvyrNeqExChmgqowaY9T/r8IKo4fhomkTPj9Zuu/m+Fya55nDVSwfwVjy/YXqXuptDgFzlODAhpGGa3Jp3r7mzE4ulivGAlH70dqk0ByeMscyxRWgXjzX2TRvWJX1brf3bkMll3YMycKd6siBIEHZKi1p69IPYfe+6QyCHtzfEqy4NoNI7wwhlDOVd5Ulzg8Ts8GfBXWFXDMeyFrPdeOb+Dimr2PWG0kAOX6m0bbPME86BxxkFVF20V3ZtlKcBJqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0Zcirlhn5cOs5xaqXXsW0IWcH6v1GlP8ug1xzbs5q0=;
 b=W169mQsmRDyjt/5jJ74xxieWmSl6rdcGVJyd24d85avRAttbaxi5gjOgym/Lq35sfH1SdjeHbspLYWGwQjWcYFjji5EY/v51OgJb4JS7Ydq9DcyMYo1H/UOdW8yrZZDeh/yqGGX8lgd3E9Gt/FYVqRPKGLBvNa2VsF9Agmbz9oOm/M5CeI3J2YTNlA8LsV+zH038L8qeYKVgaAUwGLdDWmT4doc9TiIvjGAnEKls5t31LUt9Fqp7acANJowG7RN0saL0srQSpfhjkpsjkwjVN/BoaX+XwMvgEu+ImsnppLpdq7KQkQE/dVGKOKAPb9BLfYD40KMVHnFBMuZyUYMQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0Zcirlhn5cOs5xaqXXsW0IWcH6v1GlP8ug1xzbs5q0=;
 b=n7KEUbEsh2uNH6dfbmSz0SHBLZxoXhNAzNgRgqEP5Um+E6aHIlrz0AVOKYR5z3wq6uBO9XJN7uTq0/956TrNnBbEFW7t5hjkZYZuNmPaUBRojbjI/363UtryQQkh10uEU76alAQRCKwveV5JCliAK7VIY7Sj1niR9yOaWGyt3U8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1809.namprd12.prod.outlook.com (2603:10b6:404:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Tue, 13 Jul
 2021 16:10:25 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 16:10:25 +0000
Date:   Tue, 13 Jul 2021 12:10:17 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Muralidhara M K <muralimk@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Youquan Song <youquan.song@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/2] x86/mce: Define function to extract ErrorAddr from
 MCA_ADDR
Message-ID: <20210713161017.GA16744@aus-x-yghannam.amd.com>
References: <20210625013341.231442-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625013341.231442-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BN0PR02CA0055.namprd02.prod.outlook.com
 (2603:10b6:408:e5::30) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN0PR02CA0055.namprd02.prod.outlook.com (2603:10b6:408:e5::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 16:10:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6907a68f-f6a3-490d-ad64-08d94618b9a8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1809:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1809A5263F3C7D8E43A2405EF8149@BN6PR12MB1809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpxXckb6lXxAbySJu2cvqZT3fxn7JlkUdHSwNdAhP1BZWvq7LUK9V+vGATdNsrs85a3jUIFemjsyamPT9c7FuOkKyTggW15xijGp1a3xmxQWPX8RGrAj3Hkzk79EVIpXBqpbpyUmhn8gc7s+rM/8Y+wF7LS3UgeQev/HWv9F2Gjeqrm/buJTpb3UamxXl5ABmywVWdTxo0bUVtcDKO5kSK1sEMYRIu3IuWOfCvcNJZs3vaEhC0VRmAgOjl0TLf43C+3tcw5MvdYIL/m4yLLJmIQTqN7lfWlsDtZq6KUeGhxK8C0KZtPCfbSmqZzcIMzzUI5ML71owvShEL/Dt+WmfKraYvQqORNKnDz1zL3o1TG/MOopq1FacwFCKeOkACCk+faGRaKX92mBlCrLI1Sw3YNU+OQsFqP6Yt8awTC3SQu8IYiZtdnYjefMPw4h9WEWot6TXCLhdsmmH1UAURM0+B6RpGKl6U/Y8W/26uc59z/NYMdh+Sv78GT5389XuuGq/FgBkrzZSVkF6uy4VtZI2GQj9Y2ftpujG4q2YS+JWmFEtGIENCqfW8+pRr8zNYOH0sm+EIlRQ/tjq/cTjujVif4xNYOPeZ4Y8yW7puLv3PT4YudzfPF1qt955PIgJmlBl/hAB2lg9t4XbLCuTCIOjYx/ce25MyWihX41b420OjJDzKm2/iXhx9qKNUTs6eVZpTpuAcuj5bFWCYmXI31GKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(38350700002)(66476007)(66946007)(2906002)(33656002)(7696005)(26005)(66556008)(55016002)(186003)(4744005)(54906003)(86362001)(38100700002)(1076003)(8676002)(5660300002)(316002)(52116002)(4326008)(6636002)(956004)(8936002)(6862004)(44832011)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fk9EAhNWWKqdLGY5+pzAg2e+1EFd3IdYI+ekNoSYKgEtfrnFD2bXDKUrEcv3?=
 =?us-ascii?Q?ut8eHhx0lLBC2aoizUomcWPeD28/yQYszTVVui7Fe/+EJE7IKj+/U6zX4EaL?=
 =?us-ascii?Q?UV2l42q3EuDhhVoV+xfWPkm1WlUE8fMHvAZgvTiSnp+sYexI6BAvFHokMpU5?=
 =?us-ascii?Q?Zq+9zEuHHyhzVIhrI+NnBmNEP/1zsCYrO7tNB3pSBzXJ29DP2it+lxv41ZmR?=
 =?us-ascii?Q?oPoc6dGLnAsUafzRcYM4KQGflVc8JeTHAd4aSkZkt+FjhzhQUIL+FWtbywxC?=
 =?us-ascii?Q?0Mload9Yh+lmGfVUISRKz81s/yUOuLeDRngu+QigNca5838MhpSxgiEyg1/b?=
 =?us-ascii?Q?42+ADsC4upZfwUvxH7tKjDGkGyFel3HVR11bcNxyaepXEy5ONUU5WkdFUHX+?=
 =?us-ascii?Q?LZXrtNc2+PeqybNMAg5HzvhkA40MpC9PUVYprwJqjsKC/LS31JdbZQtF8W+M?=
 =?us-ascii?Q?0/j6q3gcNZ9ECkYrk4c37HkHfNyjLEY9RJMobf4IowsjW5gtFSzfH3k1oJwj?=
 =?us-ascii?Q?f6B4vYNM2ujt4yqqFCfnKd7TbEROs63KL9bAo66Tpf3cEv+LV8+LJqb7269R?=
 =?us-ascii?Q?rdWmUxPWT/oG9+CE2vsfel9+zeqI35tJxBuxSU1jx1cXiDXuzqGFvuSlAXZ6?=
 =?us-ascii?Q?Zi2SvgD02Y/+qIG4ZjMMBb7h6UHYq8SRaSa2kLOXHEtiPdb0iWvRKIFjGz+v?=
 =?us-ascii?Q?LNng3B/P40S9/6Yms4rI64G93lyNqk4JO5zcDxawXsMTixfW0Vi2G++SRBHI?=
 =?us-ascii?Q?WzCB6tOmq+D0vriiLRJOPdHOfSOYVYDePwdapl4OG8Jbv0RgDJfBRPFl0aYL?=
 =?us-ascii?Q?XLwcZdYpdFZV2/S/Zntgl2ECYlzhoXIAyNbqMeFE8j8KAg449T0vrqL/u33E?=
 =?us-ascii?Q?kZOFZHBRDhF0+Spxh0ZBDUaSRpGX8HOQlvwT8aTfTuYuGHR3mxCVOecPIqOe?=
 =?us-ascii?Q?ir6i11UDIorjMwNnieNfxRNMGSgKUonVyZt5Ud3fJ1CRXBTvCwEIkArJ7e+2?=
 =?us-ascii?Q?x8rE/ePLHz+HFUu9vSv27lQw0H4X9PY/pb0XcwqhNjrybe7b5jz1/hdlUNd7?=
 =?us-ascii?Q?4S+T2LtQBg6o84i1UP5B/WrHxNWK8vtxB1f8l3qmhFuSl2S2G1lVJJ6GWLbJ?=
 =?us-ascii?Q?SgbwhW/p4QG2TJiSA94MehoOhblqrmxDYXbWZ2PFMwgbLOuaAhonAy8pmyTm?=
 =?us-ascii?Q?60PenooVHHZSnl2QmS3LOasOUGp8L03sUpj7ns4EfafDfSNh/W7cDVwY5RVJ?=
 =?us-ascii?Q?q16RShIxPCshzDw2OzBviVjJjguQxBglp2iCg+ctIp9f4cYnA4y+aknEFr32?=
 =?us-ascii?Q?jwzB/pvDugIvHVLjAXev9vuG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6907a68f-f6a3-490d-ad64-08d94618b9a8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 16:10:25.8903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAPoBLk7ukHeOQD+iAvc/sxG7NK3yWAqbgdUC+kB0VTbfG9eKVkLnJSH8qBN1JQ4sy3I08z8EF42cWEfGTyFBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1809
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 24, 2021 at 08:33:40PM -0500, Smita Koralahalli wrote:
> Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
> will be further refactored in the next patch.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
