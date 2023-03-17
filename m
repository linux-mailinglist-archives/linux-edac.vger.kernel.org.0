Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138B16BEB5B
	for <lists+linux-edac@lfdr.de>; Fri, 17 Mar 2023 15:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCQOeG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Mar 2023 10:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCQOeB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Mar 2023 10:34:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0267E9194;
        Fri, 17 Mar 2023 07:33:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHx3y8+zj74j4m+Knug10J+0nDfL/i37N5xKxhi9y4AJrlti/1I25lVhFgt6atGaTar4yQEcGssXx4hsQoS8QFDgfxDWHyc++G5i4tm398hl3EH9jA2Rheq5hKxxDJVIwlGGh2ydNSBl/5FMcBjstl5hjBH9DPtAAam1sLskyAA/50GwNseMuEXcJEf8ta4dfjp9EdlVhTOvMdO0bNnuVrfLqVWcV++ZEOOCnDJvb5FPzCdZ/0w3gRj2K8YJjfPrdyziH7z0nnozcn4IwIVuHXHeegK6IMHwrwQr6IThMdGkhcJNx44+UOBvGccKR+v+ayrSlRXNH8hS+l8enyHBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHwK3hpbOA+L+//mCVYWp1n8ghIRY9E/mF+WdmK7OwQ=;
 b=JhNoZcOE7AiMxGNmSOV7meGWO+WCedGLWA2iSxhzE9qj6DylnBlxmNNwMR7/+N1pIqkKfsXeMxBlxeCM4lFkSRgAl83UI/iispWMmQOl4bgXVtq/si4GrBRtZgis8+cT5DbzTLjHpPhCvG2EfcCT8RCon6U3sYIR+PBpN04WZhCqCXHQRP0KCOBIaJRtEc4cGz6CthzFWSEplpN6dVW5F2M1vATmV144CjFdLjqYK45SWVUvY5xEUuHZaaEOPzNDNlgMiJebjxOARILhPypJyWnoKEkV7G3pu0lbX8DeV6xY2j+gpAb/Wz6vqNV29JDZL13llHWRKtr/Ns0VAQ9dgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHwK3hpbOA+L+//mCVYWp1n8ghIRY9E/mF+WdmK7OwQ=;
 b=cdlw0379u1dXRw+hn08SImGwUsGYjizw2VtwINQg3t4hyjkXwzPJ47QYf7uKDb36zddajX1pXDZ3WaUJYpwihn56nEnZTjBia0Q1b+O7xPQxxuNfOS/G4yJvA+tLHuQkSRdZ5AXH5+mYSvyp2YUSTH43Rpjr14LsjGF/6lbLHKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 14:33:48 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 14:33:48 +0000
Date:   Fri, 17 Mar 2023 14:33:45 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Avadhut Naik <avadnaik@amd.com>, linux-edac@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
        tony.luck@intel.com
Subject: Re: [PATCH v1 3/3] x86/MCE/AMD: Handle reassigned bit definitions
 for CS SMCA
Message-ID: <ZBR6SWDjZs3X2NUd@yaz-fattaah>
References: <20230116191102.4226-1-avadnaik@amd.com>
 <20230116191102.4226-4-avadnaik@amd.com>
 <Y8Zo+hj8qxYpZdAl@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Zo+hj8qxYpZdAl@gmail.com>
X-ClientProxiedBy: BL0PR02CA0073.namprd02.prod.outlook.com
 (2603:10b6:208:51::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: f09b86d7-7276-458c-f204-08db26f49edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1Heq8JoDG4EN1xtVoerSERIKSLp8aPghYk5r1IMtttZYgzGkmiwJGc7sXK1q+sT8oCZZ2YGhlGZ6leU+MqHOw7ubO52z0JagIqvjfyCBqE7D54NS89ivr8bMuvLnTeNzkCjFml0VvPEs4L4lMIvua5AzPC2/capUkKlemjgNouud021zILlRUoHaPPXBWWoVAzR5C6rWe0fUM0781bA/AcaZIoNZgoQDwY+5VqlRlterZkM7GBbRWCZwKXlg418ek7QpTgDi69n3D/Py74Uq9KlIFsI+ZGtDfaaBlo4j5GMOdYUaqvuNos9D00I4hkTLT4aGZvm4co1aQT7VTJX9rA5U1vQIvicLyokcUepfMFz4F57MFu0GJTkK0KwqTja0DY2KgK/mGnKxx9Rf0eQ+n0j2mu1Lnr+odfRUQEQSlB6BwJM0K3RJTokre6Z8As/DkTfRNa5ZCT27+SYX/IHTzT/kD0TezV+IwfzvRNUE5OZNLh+Jjt3l1ZCB++z5SaSYrwR2w7clTJx48NMAk+AiQXvHKCbBg7d3+47E0qlFZffoopD7Cjnw9GfVr88s7WKMUV6tIpGoI+Xpi+EJ3cwTEU3JPDB6ZVSSsoT3NxIYju2v5UnFCjKyj+YDw0SSFZFLnbSYS8P4UDjYWaOWvuQtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199018)(66946007)(66556008)(4326008)(186003)(6916009)(316002)(6486002)(478600001)(8676002)(66476007)(6666004)(26005)(9686003)(6512007)(41300700001)(6506007)(8936002)(5660300002)(44832011)(2906002)(83380400001)(38100700002)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YApugnoh0kAYo3ktxxKWLdsz62crBxf9PVOrih7gG7OofoTj2ecUYfDNZ7zN?=
 =?us-ascii?Q?xaSJLyR7WZHg6/CWYgCHOHkRjYgtmQ9Hfonh4ipeaahGzkshIIU9W9QWVhi4?=
 =?us-ascii?Q?hy5Wj02nhptQhEsNpPTc3ajLKxptvSErefdrKTWmWPMqsmCd2fVGqHoqqVD3?=
 =?us-ascii?Q?KM0y//vxr0b5v7/kpB1fILNbmgXUgNJN0FTc6sDEnf4kdv/OQ/aGxjXcf+PZ?=
 =?us-ascii?Q?HovB5rcg7/5LDDZ2P+RjL+KuVnA7C+ajw+diml7TauTbwtAhPm/kpTrOWoie?=
 =?us-ascii?Q?uFPdGZdAnAEj57IduYn+cfwT8E5z40Ldz15vXaXA1gXnHowl/2sXgnT0FzIQ?=
 =?us-ascii?Q?CHqL7k3B7xug1aUvZvjfHRQG6m8WVG73968+8vm4mgmWHZZzTZEre6jkWkGj?=
 =?us-ascii?Q?mUKBEKHomm2O+fVWb5zerzEqiTfEq+D7I+PRV32/OqePM6jYgDxcjWYZjL+0?=
 =?us-ascii?Q?EtV7IKiPeoO14JsWxTcUXt4BbdExZzqNGCB+daRhE4PrxVPlT63mOun2Tyuz?=
 =?us-ascii?Q?tU6zQpi3IR2Yfx3NrsmVNXJEuWUjG+QptxfkPdHCMG3bTBj2Mz3E8p3xm8jK?=
 =?us-ascii?Q?fCiSGRNbcb0IngD9LV0d0imFGOKK6lR8IOYXgpgqLHGenlJ7qyDeHwxzSpG9?=
 =?us-ascii?Q?E2PSED91nstQz0RIQVQjDqdQwT1V1cdffVHdV0rDhh2B1/KOhErrf2pbw3e8?=
 =?us-ascii?Q?n5sGOh4KQI6IcyKHAY/4BLONmXtdtQ1ZPISBW8tB82EqE/5nVL5zyzGyJRkf?=
 =?us-ascii?Q?VjTcstol0MsUhIflOv1K6M8rVfk8dMdIIUV48+ZtcA/DAlAE621EJfB0bSH4?=
 =?us-ascii?Q?ftFheKqLo4pPqfi7Vze9W9IkoIJU2WuyJ1/pppCNFlseXZKmtTNTv6Tv8Koc?=
 =?us-ascii?Q?BzzzmpxbqmJNCzuYsR4Cws0mqz6vYoIoXhBbnlEOnniFQtfex9wH4Ij6aIW1?=
 =?us-ascii?Q?aDGZrd0/pTeRP1a9jejMsnOTiYTRQ2pwy9S00EA8qcgS0OjDfAbeRJZnRfyF?=
 =?us-ascii?Q?HVVewxMp9RfK5pallD6nTL/t9G6vHfwaF1SiuxT67f3ptM6eJUUdGS/F4GA5?=
 =?us-ascii?Q?sZfymov9xvfA1Xq/BERu5KopXa/+Rk3sOC5PydBbffhh7axXSbyy+IxmQBrp?=
 =?us-ascii?Q?HHpX+Yxa4p3c0O3cmIGvXGR2cxWlsA2X77CSOMo1d6xYVWmTOwuA2rZSJZfe?=
 =?us-ascii?Q?KNVu2aSoK/Yodr+lhj2ZVkwvSOer3qe56mFg46apO9kPvu1XzIx6VHh91eq0?=
 =?us-ascii?Q?0SeVN82oiUAL8EwKiNKgwSwB/T4bqW5zcZLB7isAaUrGlkQZyH0slxLjPT+E?=
 =?us-ascii?Q?GOxqlZ5qtyvKZaEPb8yP7+5Gb4COwqs7yzuvtf0oDZLXxBBcDhSrzMqEJ5bT?=
 =?us-ascii?Q?l0gMoBRdqWHsf6YQSyNFROih2C9xPJkI/tABl1OBPmb996QRZROvaZe3Qv19?=
 =?us-ascii?Q?RjLXfcJ27wu6m6+pE/+P2dc1nk20yPw8BC5dhxd9in2SuS8Na7nlpXyFdpss?=
 =?us-ascii?Q?+0EywGkdQSQQDctm9u/1TbDwXmlFORCdLaNgKuYpEu5NFhHn+Sm2GLLZjQux?=
 =?us-ascii?Q?rt483qZpjlRdh7H+fn/cH5vjFZiLPKHMpPUFRz8X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09b86d7-7276-458c-f204-08db26f49edc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 14:33:48.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTz3ALY3duaJ/TN6EHFiQYjOY5KnoHAlig1q1oZ76vKAMpOkvPKoCtlKOxbhzDjUQ5k8aC9sTE42ig77McgBsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 17, 2023 at 10:23:09AM +0100, Ingo Molnar wrote:
> 
> * Avadhut Naik <avadnaik@amd.com> wrote:
> 
> > @@ -178,6 +178,8 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
> >  	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
> >  	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1)	},
> >  	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2)	},
> > +	/* Software defined SMCA bank type to handle erratum 1384*/
> > +	{ SMCA_CS_V2_QUIRK, HWID_MCATYPE(0x0, 0x1)  },
> >  
> >  	/* Unified Memory Controller MCA type */
> >  	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
> > @@ -259,6 +261,17 @@ static inline void fixup_hwid(unsigned int *hwid_mcatype)
> >  
> >  	if (c->x86 == 0x19) {
> >  		switch (c->x86_model) {
> > +		/*
> > +		 * Per Genoa's revision guide, erratum 1384, some SMCA Extended
> > +		 * Error Codes and SMCA Control bits are incorrect for SMCA CS
> > +		 * bank type.
> > +		 */
> > +		case 0x10 ... 0x1F:
> > +		case 0x60 ... 0x7B:
> > +		case 0xA0 ... 0xAF:
> > +			if (*hwid_mcatype == HWID_MCATYPE(0x2E, 0x2))
> > +				*hwid_mcatype = HWID_MCATYPE(0x0, 0x1);
> 
> Why are we open-coding these types?
> 
> Why not use smca_hwid_mcatypes[SMCA_CS_V2], etc.?
>

Hi Ingo,
Is this what you mean?

	if (*hwid_mcatype == smca_hwid_mcatypes[SMCA_CS_V2].hwid_mcatype)
		*hwid_mcatype =	smca_hwid_mcatypes[SMCA_CS_V2_QUIRK].hwid_mcatype;

I think that's a good idea.

Avadhut,
Can you please make this change here and in the other patch?

Thanks,
Yazen
