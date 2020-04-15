Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8F91AB346
	for <lists+linux-edac@lfdr.de>; Wed, 15 Apr 2020 23:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438891AbgDOVUl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Apr 2020 17:20:41 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:32288 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438818AbgDOVUj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Apr 2020 17:20:39 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FLEksq010310;
        Wed, 15 Apr 2020 14:20:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=pfpt0818;
 bh=RWAS2f5CbuBYhr7iOYbeETIIz4Gt120dhBXJvlbkzvE=;
 b=dq1hDCWLzNRXO0vwQRco8xfE/2qE2HPvkwzd0t6cx8z0v5+wkNrbzhnmvheqLLcX+tln
 CeFSVQGkIlOr12dSy5QxeobCLfQhRSVSDKBAfwlf4FL2atOBmnxX8JbmWEEEGctpUglj
 glv0WuNQEdsFI66yeME6c9FQHy/eV7KxFyy3u35iPGL/QPufsu2nM/KaVsOSX+MZaRZR
 4rVwmCTuNn6KWxkDq+VHaQmeDiD083Pm+YnM71xJdeSZVx1zEIJwtH85qk6OHbFXaqQf
 oVHLO75dj+sNsPM/wXOJL95R+3gIp0YJKjfm4NKlqrQZ258Osk4pefy2pFg2TJPQXZyN WA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 30dn8gm61f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 14:20:11 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Apr
 2020 14:20:09 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Apr
 2020 14:20:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 15 Apr 2020 14:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhkJffdJQGCrXryXrstJ43lTnzsn/ikIPAxtMCkpO4AedHKFYHwjBvoHobqbJNCFLWyxFDJS8tfcsZ8JjcPPDv0LymKtwFrawyv4A68xL36Yh2qZiCflf/0GVNMwE5VdrT7GPhD87cW9t0d7VToMSuPDtBCrAgoOTOd5fe+CJPVXD0Z0JlgnoKL1EQqWCjunbyIC8FH9UoWllHSmpbObaL1rfhWrnbG/LebWFElFjJTKCSo/ZtQe5v6HEaMcOMcZVBc1IoHsIyYM/LiXo01dWv+VyLvpvT9lPUP65yrAtKN7Fo+9bU50o9jI1g7l3mx3yKO25z+w1RQgl2kkDvKMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWAS2f5CbuBYhr7iOYbeETIIz4Gt120dhBXJvlbkzvE=;
 b=m6K7Lf4N+5O6kEs2LUe1PvupTYgWruSNQJJBz9calLKSpoHt8bAL6Toy9ccDyUMhDBQje91AIzbtY5Am/j365uX7Mji10yX3Rn+tP1P8TQwyWLfKmhr6/ODzo/StdpTpNKEOrqiv4PeEtM4MucICR45C3QGll7DN2OqI5gK3lnbGSHn7CfxVxViwXuthwFojtoAN9eR5bsLc0iQJpzXe5fDCT71JoxjrGK0KzCx7BZZdUUqXK5gGjS9I6rVcC01GL1W6+GlL9n8F2UbBMdSe40Y/wFg5B+f93FNu6Dgbl29LMSrRvlYtYBi+wsopJR64z0LcMUyjd2jNfy7OF02QWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWAS2f5CbuBYhr7iOYbeETIIz4Gt120dhBXJvlbkzvE=;
 b=S1mXK+MVQjFbjTwNJEPf+7lxVwny5FsfABy8OKjGL4KYb1oW/zjcISQRLROVA3npre4OOcsfWPhaxGnWIhWjCK+7bTTYDAkKRKNHvYLYLJ17h8j7qvaK1tuzgq5QwzOugn3vBswQYAhbOu0skp/19pA6eHDNuCnVc1MW+Mj81Kk=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2759.namprd18.prod.outlook.com (2603:10b6:a03:10b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 15 Apr
 2020 21:20:07 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 21:20:07 +0000
Date:   Wed, 15 Apr 2020 23:19:56 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Jason Yan <yanaijie@huawei.com>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] EDAC: remove defined but not used 'bridge_str'
Message-ID: <20200415211956.nnvqsjt4ekf2qido@rric.localdomain>
References: <20200415085006.6732-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415085006.6732-1-yanaijie@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0139.eurprd05.prod.outlook.com
 (2603:10a6:7:28::26) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0139.eurprd05.prod.outlook.com (2603:10a6:7:28::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend Transport; Wed, 15 Apr 2020 21:20:04 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 395c7210-0069-4d1a-5204-08d7e182c533
X-MS-TrafficTypeDiagnostic: BYAPR18MB2759:
X-Microsoft-Antispam-PRVS: <BYAPR18MB2759EB7AEA2F1BE196B952F2D9DB0@BYAPR18MB2759.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(8936002)(2906002)(316002)(4326008)(55016002)(186003)(81156014)(956004)(9686003)(8676002)(5660300002)(4744005)(6916009)(6506007)(16526019)(66946007)(6666004)(86362001)(66556008)(66476007)(478600001)(53546011)(1076003)(52116002)(7696005)(26005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iv5YlADogKG+jHyG3A7qREjppuP6mHAjZ8AmKsrUA7gEJiZMMH3svddep9v+XivblFuT53rNeGEKvHe9YO57SzGWO01JOxqfzD9ciomblM+TPDza4uM2k7uBbvV0tR5hQCKq4gYeubl267r0+g1eXEXQvNz5KGPdJKSSoTJntCIzI5f8WY3LU/Y9xWWrzQd24xLf5ez6p9Z6JjILU4qjGD2zlcuVoOpXSHefLdIQiab1g9t2urHpqaH06oEwDhFskG4vB/wP+u/wUxOH1uJgO06tXkJaerRnR7Eay7CS2/kEmRnGMiyfQVJSKLxYXoZK55ePdR91jtwxklAA0bmFpXfWf9MXlvEV4MMNk4N4AGtfKxrn4cgUM/P8zyQFxdtttu9GR6gmPaZ3t33d/80G+1QsG5vkFFUN9y0FLtnQOcsDrb/M2TR2tDvf5lD1NOU6
X-MS-Exchange-AntiSpam-MessageData: ariM+BmLFusoBIZy40EQH+HsROF0JLgvq6kURWYuPsR9MQ0lNnFFu6oZEhSBM3CzFe2Cf0S8c0Vt3iL5v6z7SBY1xAMWhKmikkNTaASbfNVkkDgFtzkdjuCiYWd0xODMfNFcqvNA00ifFfOwvLQyMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 395c7210-0069-4d1a-5204-08d7e182c533
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 21:20:06.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exhEnqwnrHCokmkDiObOS0aQj2FHvEAUBf83ARYYqiR0kENHkO4JqhTjSWvCiEXvDUd8wIR9iDQ7fimIJlEiEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2759
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_08:2020-04-14,2020-04-15 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 15.04.20 16:50:06, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/edac/amd8131_edac.c:47:21: warning: ‘bridge_str’ defined but not
> used [-Wunused-const-variable=]
>  static char * const bridge_str[] = {
>                      ^~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Robert Richter <rrichter@marvell.com>
