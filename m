Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815AC61507C
	for <lists+linux-edac@lfdr.de>; Tue,  1 Nov 2022 18:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiKARWW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Nov 2022 13:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiKARWW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Nov 2022 13:22:22 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02871ADB1;
        Tue,  1 Nov 2022 10:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0gz8fgz2Z4bOpL1ZkjpYyJiREngI+9ap4AyPa98A36bLFa9CBw4vsuawZWQnlFN9yIL2D7hFv3dJhOmNjODUT6ka4k8qxTxv+IGSVCA8nzzL+WD+efFER/naC0TLlBYviPMloCO31WsjGX13HoofPKfeeJnX/2p6RDJaOcqCIe5Wp8KA7KSBwOGq5rjLDPkC6hQfgQH1+uJ1NRJStGz3AWt6yBoRL5e0L3CW7u/JZ6fpdyYXoLKvpTbxgF2qLUCHCyfaKDdkVetH8KwMD1/x2zoU6qMgg0MMCp1YQSpvx9PlDYhcwPUxQ9E5Alf4kFQbZyERBqHZsfBZ3M4JW+zBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+yH2kKhtYC/XzVBb8lSuM7t2ZZURMBzJ6bbFJhd69Y=;
 b=lOm3phQktaQz3TuUY9b+qsTYYqCeQ7vxSYafPeCBDBk5lQlIi617vgkBi9DtEUi+rF5RnQlYuYyLxLHegGenXsduN5ocuwX4ywoIEtGmLOcR/jEcMxfT9Gw4sx1ETZ0erqnhoDXOmzySJLemh/wABmh5crEQcYxkfgIAFE/qRrMdkGuHBb5rMoNZOikQW4t7ZM/4cMRnAj9tvVEaMNmT8z89+r2bmeGjAab+c189HJAm27eMLomUyXHDSMxg7pA6Ck2xuaz5EWTNLj/RLL5CNm55wn/OdSlkqyyxDT9U3+QW4gUUnfDEOuT1JdlMxpdqJF+u+aqKwrZt6AU2Uh5nGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+yH2kKhtYC/XzVBb8lSuM7t2ZZURMBzJ6bbFJhd69Y=;
 b=RMdnSB+FDg16D00pvEdoFIkOff1fYsr/eRhJ4pDmVrdT07dAqkIsqhMZAd5eW2K7HCg2K5uKi/mbCWSkvDPcHDmeWY7j7smtrL3JA6HMJCQI79Te6YgfK9kU+mAT+Pl/HkqqbSblgU8naZEJBMZdP9FckXDGt0Xxc2QyizD5efo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CO6PR12MB5491.namprd12.prod.outlook.com (2603:10b6:303:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 17:22:17 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a%7]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 17:22:17 +0000
Date:   Tue, 1 Nov 2022 17:22:13 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Subject: Re: [PATCH] EDAC/mc_sysfs: Increase legacy channel support to 12
Message-ID: <Y2FVxWXnleYkkTGL@yaz-fattaah>
References: <20221018153630.14664-1-yazen.ghannam@amd.com>
 <Y1+i5GvygCVfiCGx@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1+i5GvygCVfiCGx@zn.tnic>
X-ClientProxiedBy: MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27)
 To BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CO6PR12MB5491:EE_
X-MS-Office365-Filtering-Correlation-Id: 498da115-eaa6-449e-e9bb-08dabc2d9fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvyhwM8o1ZG78/e0S6EMNnXepzIulTOswDalxsNJgjqFumENGVSjiRfC1bOkJRCSq3+Zy9kxwhc34LQ2AkP4sQw+/DfbmH6UeZMAaWeiUhnlgPm9LpIzV2gD+RySBMSpf9aOh2nVeKMVcS0iJc3Izw4uUL3dh9QDPz1ZLOnZtqYNqNLrZC+Ut0GkkjZcFLnOrjEtHkaF7timga9gXcc59VBWf/Jo/ahO2+RGH0z9WLnIlPq5nIQJRWKdKtytofaMiY1ji73XFpqYWDlSXVItoQPWDPeSvUkIXj8+cfwEdI9RhFS4r7IwyPvGguzSINCheSyAUKk8Wgle4XpM76bGPcpIZvwFLqBAtIbYN1HE1vOEvom+ocdg6jiBiFgszEOItGB0g7BLDHKVRZOrm9HMvOyF+8z3Pwu7sb9wu3EDfJwdRGBn9ZsY7ruFgIJARCmhSUPrPBtg+H+HmLsrBj64F3N0SXowNDDwNJFviA/UqlQWEZoh93CmwXc8eVEJYOcHIYxAo0iECIFiipeA7AmqZ/jGvegSn+aLR1mV/Dq98RjhbYh7BhloYHt8V0Ztnc9aNlcNaEmd/H1ZIwWQiFhvAGt/BCflcDs424O9AJlqVUSwX7TE4GtR2IDyS2Z/oeHhSKAnhv67YI0WFwcVjDmQMjMxRdQ7/T0NRGThUB+QiDM78j/95qVCcoCYivH+9EpwyF0DnhkjqLeGTMQwrVpjEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(44832011)(8936002)(5660300002)(186003)(6512007)(2906002)(9686003)(41300700001)(26005)(33716001)(38100700002)(83380400001)(86362001)(8676002)(6916009)(316002)(6666004)(478600001)(4326008)(6506007)(6486002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CAMubdKnuVhklOcgH5cywBI1Xr3ULUiLvF4eN7QJdKV0fKzM47Spe5lN6ov1?=
 =?us-ascii?Q?OL+Ok03irmL3KQz43xRqneWVx1cIa7nj8rB4tniCLJ5bEZvl3trCeo7Bq8KR?=
 =?us-ascii?Q?ctGeBJab8i47yKV0Vh5CK7xZYz9ZeckEYQUh7mylcI5khGt5Y64Y5TY5kckH?=
 =?us-ascii?Q?cpMWFB6NjLs2rtNscXxVZG+lMB23P26EFS4oqqDkvc1BONEnp3pfsUP+vbZ3?=
 =?us-ascii?Q?iMSIVniaOJUNW8GmrcfxOdAC/0NSK9wYNjdLypClBViiGv5TNKGT3+XTgMVR?=
 =?us-ascii?Q?TXideG0PkmmNoN9kc+jcdmvZY7NPrQKIFGzBTTq/Wy/w0EQCBn5zElPF54kK?=
 =?us-ascii?Q?r0Gm7g2vYPhF7ZCvzuG7NXVFKOWt0WBqUxPa6/4CDF0Rt9SvYps1rORRbh9k?=
 =?us-ascii?Q?k1I8KKqJNsWkxM2YeXhtJWJv3RXNbS7Ac9k1t/hmJWdX6oYTXGUCsteAhn2Q?=
 =?us-ascii?Q?4HnEi0/6zVh85TA9ByBTLB+AOFXQmyZXFsOvaKzMRF4YKB+I1CN4e6RmaIfS?=
 =?us-ascii?Q?D2YVFgjaH3EVmmDZ2edSN+dMb3CddHcWYbOOWtPukY29ubfSXGZyV3nmFf2Y?=
 =?us-ascii?Q?YQA95x+pN2/DmWSdC5Q2kmZ9Qj5nvE94el8cuWbzTntHKA7h3wADJDkHMwM9?=
 =?us-ascii?Q?HNPuQhzHDKlGZoUrK6I0Up2QQAEHDLaD/sq9Lp883cOazxklF/VOuYaXO/Pg?=
 =?us-ascii?Q?Mmb0uLoB+m1DJqLXjeeOd4TpLdiu1iaYfDtPLuRdkunS30CBO0oPHM0yGug5?=
 =?us-ascii?Q?wSYra0dtFQq6xXrBgso9qrsvURY0LwS8EQfCX0rlZF4nM7qegrnP0OYettKD?=
 =?us-ascii?Q?ydEp0WPMZS/382nQhMBQ0S0ssvC0jVNbxPCrZHFA2fP0jYSnI+WxVTJyz82C?=
 =?us-ascii?Q?TuFCa5rC2+WjrynOLvUE3ShE3S6lr1CnL7ibtmWgbSytvkcYI8cCEu20Eyx0?=
 =?us-ascii?Q?bY86vpmDZlZsP5t2k0p9DENuJsMe5fj86pSEGj2Ra7MZ/soVrVyw8cO1mPIS?=
 =?us-ascii?Q?BeZLJqmfM2LM9kOXUVsD6sub6oPyK6YXoZXgadcBlFpv+/pzuPyyAVDWldda?=
 =?us-ascii?Q?OBrtJsQcQ1GegN3Iq7g+4ZTiYiVSVr1aSeBCTm928uP2U4kq09YrLONMNH2B?=
 =?us-ascii?Q?/fjD4I6JSqCUGXwr7fB0K4iRZdqpuIMTM1UfRIn4R1YSU1XaVeNWDhQQ+kQA?=
 =?us-ascii?Q?E2fx/D9bKFobPy9f6KRVKZRWwKD3RWQvCez8geZ9dbfnOFEvLgDd0DzUFC9v?=
 =?us-ascii?Q?ILxWmD/lrgfVPhAQ66OEDH9+l1Q7b9/juabQiGQz7dfhT5ZCkZhLU0OM3stw?=
 =?us-ascii?Q?ae/uzFd8x8xbTADM4+7BRvrBzhEj4Ib0GqWIXMaVBzCksIW52q3ukTYMxPS+?=
 =?us-ascii?Q?l9gyuANRtt09dIieq7NMrToOOCMP/ZpUfbS8e+3f1jD3mzzQXohOOZxaJJCn?=
 =?us-ascii?Q?MVD26Vi+TdhirSLvwwTsOy2G4AYsuRBroIr62TAiJujleQjAp5zt5PJt+1uY?=
 =?us-ascii?Q?fxNDDwPAgaX1AORQmkVuriW1BexO+qsVwSkJFZqoMJCOAn4g1bhTiIdgNmXk?=
 =?us-ascii?Q?YsKyC656NHerTs7NLnS2exeUf54mWy/sePpZviB3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498da115-eaa6-449e-e9bb-08dabc2d9fda
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 17:22:17.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhB9494S5MK5dZ3kIQw5xUlTsC0uRzcvRDbZwFfvH9iZk44H/3wU8vnLoFYfBBJn+vTTXzzfUv9GABH2PXSbig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 31, 2022 at 11:26:44AM +0100, Borislav Petkov wrote:
> On Tue, Oct 18, 2022 at 10:36:30AM -0500, Yazen Ghannam wrote:
> > Newer AMD systems, such as Genoa, can support up to 12 channels per EDAC
> > "mc" device. These are detected by the device's EDAC module, and the
> > current EDAC interface is properly enumerated. However, the legacy EDAC
> > sysfs interface provides device attributes only for channels 0 to 7.
> > Therefore, channels 8 to 11 will not be visible in the legacy interface.
> > This was overlooked in the initial support for AMD Genoa.
> > 
> > Add additional device attributes so that up to 12 channels are visible
> > in the legacy EDAC sysfs interface.
> > 
> > Ignore checkpatch warnings about "Symbolic permissions" to maintain
> > coding style.
> > 
> > Fixes: e2be5955a886 ("EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh")
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  drivers/edac/edac_mc_sysfs.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> 
> Applied, thanks.
>

Thank you!

-Yazen
