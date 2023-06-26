Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016BE73EED4
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jun 2023 00:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjFZWwH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Jun 2023 18:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFZWwG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Jun 2023 18:52:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59076BD
        for <linux-edac@vger.kernel.org>; Mon, 26 Jun 2023 15:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687819925; x=1719355925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vfLVPKT61xYqCUiQ0msfcjGCSLEgR65hOqTG+CgMKMM=;
  b=draAiw5wwiS+/5KMkSv+Lr95UNBbMWrHVc7MzDuoeqOOTFIRDQ4yMUcq
   9HwAvgrS9RFSD7WxMBgwF9va2m1WId0b+/XLJgxXWBy0svpvPqEIovifT
   rZIWckhgIP6cFFfUwyuR0uecuR9iFSMB9wINutRbXK5HGYLrLLqZsSYvN
   qn5tbftZl6WC3Nh1mxkul53O3YIhUvE/qUA6IoIRpOHCMidVHkN8TB95J
   OaMCK+28BTWhJIUUvN3bZQg1Op6XX+/BfyAjho0OprUcShoX/NkoGnsc7
   Q4Vrd1Xw9ALVmYTX1i5o2I4qL/bw0TkcdgzyJJ+HHaeAm/PaAmG6e9fxk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="340997558"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="340997558"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 15:52:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="860866522"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="860866522"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jun 2023 15:52:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 15:52:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 15:52:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 15:52:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR6YMweGUBFhaDnSRoE7/MIB9RsdY8Hz43RSt7jWvFd7SW1gsP/Mhn7DeZHkwCm2YBemJP3uLPEs/GTgWs0bR/aVm5uNp2XtyTvDFxR+mVvSaNAqFO4b/TBtd7O6KrXxsNEKdUTzT8yJwMwiDZCRk3Dvi8WbBfb1c2cjlCrBx/LeAkFaKOBFH0LwZEhDjl3YY7RDyOysKOLYL9ej5d5fR99ko4Zm6/jXcgUPeAnv1rBQ95CsNVsgVYok/UNPTrG+dUAjbcJUMAdTD0PAAU4sr5+5XBSYPatqGt8T1Y5CXPfuFpVj7jPIiBoDQrLHpQcWmYUaVmhduFuw5OZhCOsb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q4+gZGZGjwCsowxbegmwZZEjwGD6FH9MKwD8FBHhEs=;
 b=D8rmdhGWg7uTX8QcvCNntji9ksVizqZoxwaQhWzMWqEkJKiYgknqNLA3a+iDbhyJBV4NZTz6IgoPmLoLhN12TxZ0+QHt/KDPYXkZNwN5eZm1D9fgRsUc1D2WauoCL+2GSrPVKytjk+iUZDkajH8WTweVP1hAPMVN5LameGvnkJ38heBUOMbA0erPanpvZuteOt68NfpRKNMBsgsMyRwwR1NZCpGvvBGYpSuWFF/As8FRg2PxdqW0+FtF7hrwtRJriJFbINhAU2tH45hc1vSpr9ajtuxS9sbbCCsFXXjXUxhjGX8ADoVykvxDlnsMXs5eI/MW74er6Bjs7kjahBqpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LV8PR11MB8607.namprd11.prod.outlook.com (2603:10b6:408:1ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 22:52:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 22:52:02 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aristeu Rozanski <aris@ruivo.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "aris@redhat.com" <aris@redhat.com>
Subject: RE: [PATCH v2] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH v2] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZqG4PqEB8Dp6GuEuzya4bhtDkjK+dq22kgAAAjtA=
Date:   Mon, 26 Jun 2023 22:52:01 +0000
Message-ID: <SJ1PR11MB6083D9C80B75F32AAB52A939FC26A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230626203712.GW4090740@cathedrallabs.org>
 <ZJn8lbn5DzV0k+UR@agluck-desk3> <20230626223220.GX4090740@cathedrallabs.org>
In-Reply-To: <20230626223220.GX4090740@cathedrallabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|LV8PR11MB8607:EE_
x-ms-office365-filtering-correlation-id: d26ce6f3-3498-4bee-0289-08db7697f495
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bf1YLbh5Ig5TWCh5nD+AioLFLvLRQFabtc15iwRCZDjTkA2corI3Dbh5+gG4Xtg/7pQ35phx1JV/8ktkoJBTCEWcRyrjNql+er9Zna3xvozfPRgXRIofnn9KR0KvtjOX8j3tKcA4/CR4QOopqhISjbDznj7gGIQ6OKlhtKgj9txeZmZmRDHpvdUrodleYEaK9KjBJllXdl1B5cjhx5t51+XECW+8ShQR3YsPEl/E1hKLU4tdNRsiF+FmvLToCd5kt8Ddq0FtRkeZZvo9fqGQT5Z+kRvklZlAaPXzBzHclGkLUVTCskFSJBxYmhKHZOnJQPsSB2F6GR8nWtC2sEv+BEebB28b7NJ7S2nukeYhCCxccRtU7J2BCF9Ty4WAugZRiOqNZRxdPcEf0QMSEdWS9sWss0ba8gTHSLG434oO27XTAlaqu+MOOyinNFF3een25ShKo5MmTToTDgZlZHjOCnQlSN0qI2sIepEPtWC68Lat+UZo8GnvsgpmmbRlHm0S6778Ne79O+qydexFdBIEnF4icn6WKF/rZOT20sMEZ/k/ebVs6MeFeD3hw3LWn2Cpn52gYQtmeNIf688NJV8QHQd+qqk9N/PUqRKzygRyZaI/igmlY3q7Pyv51loDurFo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(54906003)(478600001)(7696005)(83380400001)(38070700005)(55016003)(82960400001)(86362001)(66476007)(64756008)(71200400001)(66446008)(33656002)(6506007)(26005)(186003)(9686003)(66556008)(66946007)(2906002)(122000001)(4326008)(6916009)(52536014)(41300700001)(76116006)(316002)(38100700002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sxGcVE3DgD9bJqWEqF/wWoygTUIh4CpgMdDaG7bl5gFKWEmLffbGrQtgSPa1?=
 =?us-ascii?Q?p6BuRqDey4WEQ88r6sNYwHvo99I1bKadVY6G69PnvrWh2VPHpctqEL+o+oKv?=
 =?us-ascii?Q?M/cPIRMxOlTNb3a+yyOXT4Nho81JgyZsHk0kPjcq90zfZTbli3AKvAXWCCmK?=
 =?us-ascii?Q?jnJieW/+VB7kJC1Mtm23RHoB5jC61WV0XuFunZ4yRG7uTkmeGE8CxNJ20ViW?=
 =?us-ascii?Q?02DTtvvOxNBgFuq323By6JfF9Ev6VcT7Jm8/Q2yvUurWO5jXaLvTj8bwEOdK?=
 =?us-ascii?Q?/5CqeY2jJSG8lfOKLgUCdMvOFrbwOP6ouHXYPvjQbXisk+8EZPvDE+hMMzC4?=
 =?us-ascii?Q?/g4amD52VYtzl+a+flshRa9JbKcGGOIVhZIAmseKYiwvgFnLSybQuVT3cSDX?=
 =?us-ascii?Q?LT8oyDwix/7YhxFsWiH9wonbf4y9iKpZ9pkbkg3qrH3Nh8pQNXBcA9tAQIJq?=
 =?us-ascii?Q?oVAeuJFwv57wATUTvm1HspoLTUmpDrWwkDNBHYYVwRoNkqkLnVBqZzEnFb4U?=
 =?us-ascii?Q?+1z6n6aea1wfR5vVaz8xDx9QfqUk9eaJ/mDRdsod5Dzqkh8DunC1I6iAAe9u?=
 =?us-ascii?Q?8121q6zZQpr3y/fL4hT/8AKbEVh4QvcTp8T6aDAYmVCCHBiN968q2NmOMqlx?=
 =?us-ascii?Q?0C2TIbqMcrvFui8oO/V9HKm46QabHuUNoqOEmN4kSnpSlT0P0Fide3J1Vic2?=
 =?us-ascii?Q?cLp3uMaK5FZQGfa+28hQzEDlzTrWuKMJ2Q36vj991g2NmeOHYwHEPt0jM2YY?=
 =?us-ascii?Q?ZmOYu1mCHiQq8q+479eNov+vgKmoZJurYF7pIE2GHW/7CSXYzj/eeILiwDCK?=
 =?us-ascii?Q?XWFSoft2pfFKn9V/iwwSJzrGvDvnZ8bMWoywadWr20HbwTxxgMTp+P9mvz8f?=
 =?us-ascii?Q?0+Rya3ITcMSA01wcONZXtUBwaJyqWO3eNG1DnOYOfGVijgEKx0MS2Ixa/WYj?=
 =?us-ascii?Q?SgfsB1wvpK7qXFgdBqFOe5qmrXptVeiIGtvANYIqjiruU1jSNBQB2n/T2X0C?=
 =?us-ascii?Q?R4YOtjUYqfhKFWFcb0qQSwwSo4RKqOO8APvoKuxfrHkjd4f1h79c3T7jQe7+?=
 =?us-ascii?Q?Aew0sGCV+I2tLPB9jFXtXOwiU0LV6hZLjpyViyZCX+CKf1rgwoNseL/WlWdL?=
 =?us-ascii?Q?npeTy8c7u5pV2ChycctQQqwVsiJP82t9nyzpW57RXTpMEVfq4iLCOzt9Vgqr?=
 =?us-ascii?Q?4shT6HX19S/30qf1m+eiJM1Mwi/4q/UNAyp0wVE5CbvabL1VOhqDjTkEy02k?=
 =?us-ascii?Q?0M01d/RrlIKoeELIsEE/tkNBDbnsxEKxveeH0sG8uz14d9lCStAko26pvBuH?=
 =?us-ascii?Q?uJUYEWIoDWGuTNHWTA7B/S0c7J/S2miX3wrEBonTPg/Wwck6N7cgaVQ5ZFQR?=
 =?us-ascii?Q?t1LGN+APwVzGLcEpnMWp1cosUvUpXe2oHvde0yG5zaURe+d1d52thLnrZu2c?=
 =?us-ascii?Q?mIH2luujjNeMdLAw3mOfwzmZu49e1pDiQ9d3GmTc1g0z+lav8C344/jY4yv6?=
 =?us-ascii?Q?YhtRjK8tJG5pDGMOOvz9mUjnn49XQQCyVyFYQ1Bw4z6kEMFQPc9ngbE6jiSl?=
 =?us-ascii?Q?kE9On3q6syG1BfwMxGc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26ce6f3-3498-4bee-0289-08db7697f495
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 22:52:01.8583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9RY2bnFfSwIhLKER+stYKV8bOBsDjvPZ57kWD3CJlWGcqtagVhPBBasNhjwnG7RFXNxDUjo+7vQU20ibsGzOIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8607
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Then this patch can be improved to have one lock per package instead one
> for the entire system. How do I know which package the current CPU
> belongs?

topology_physical_package_id(cpu);

But it seems like that adds a lot of work to find out how many packages the=
re
are and initialize a spin lock for each one. Just to reduce what is likely =
to be
quite low contention on a lock in a rare code path.

> Or is this OK because this will always return false on AMD?
>
> That was my intention. I could use a static to only call
> cmci_supported_hw() once (that in fact could be useful for users of
> cmci_supported() that actually just want cmci_supported_hw() but I didn't
> want to mix it with this change) if you prefer:

Maybe the function just needs a better name. Calling something
with an "intel_cmci_" prefix from generic code is what's causing me
to step back.

What if the code read:

	if (mce_available(this_cpu_ptr(&cpu_info))) {
+		bool locked =3D serialize_mc_bank_access();
 		machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+		unserialize_mc_bank_access(locked);

As an intermediate functions. With core.c declaring:

static bool serialize_mc_bank_access(void)
{
	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
		return false;

	return intel_cmci_poll_lock();
}

static void unserialize_mc_bank_access(bool locked)
{
	if (!locked || boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
		return false;

	return intel_cmci_poll_unlock();
}

That would be in-lined and almost all disappear for CONFIG_X86_MCE_INTEL=3D=
n

-Tony

