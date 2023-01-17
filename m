Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E1F66E558
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jan 2023 18:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjAQRzW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Jan 2023 12:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjAQRxB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Jan 2023 12:53:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E8C4E53E
        for <linux-edac@vger.kernel.org>; Tue, 17 Jan 2023 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673977360; x=1705513360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VBzIuc+9EtEFIjc7IJO007xL9pw1yxH2LpnfExkNxRM=;
  b=IqTjVRhT3MKRMeG+CET/b23801pWdTPrdAeMrEpgHEpo69ns79HNMH+O
   eywrhcI1uB5/LhpEtBsGbLJHTQBFwF4w5MW1y/87wUJlO2nc4z9QMf3YZ
   Ll6a/qjh7UVLmoROxw41vp3q4+5Lvy+q2BNfaL7twzZAiJbQcdkAM3De3
   7dQ/GVmWukzCkcvoykWhsiETaL0fC5Jf/HWqZUEmBk2Kjyj0ZMdbscyno
   nBpxdH42a96UIjV4OnPPw9K3E9hNQ8EyQuV+ooAVwbNaojmcUrmamY+i8
   FZfgwFP83LukbGqaL+AfLUFB3IqzI1pnxKNMc2hsBp7zMPQahbcXANiOK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="322452302"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="322452302"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 09:42:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="727866319"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="727866319"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jan 2023 09:42:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 09:42:38 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 09:42:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 09:42:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 09:42:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QX+rkwfd+A/PrryS0RJ39zxXXENTGyL0Gx/6C6eva6UzgXwoOcMeaLm10ixHCNx0Ge6yzsrXNgzrj7pXLdpz5UGTIeJEcWDgL6wj9ptUqbM+QiiB7k1uawFm7cm1DpB5rl/XcyDzaxrrKBdBL8uXPBatjrXTY09jUrhIeAek5RU2UWe2rFO0P+Tzvyvbn+4bP9CwTdtH+x27lIQhbjxsSaqGt/P9eZKyahqcCPaBPYOPlgEFzRXuzYQR1oBICDnRqGQR8FavyKhmIUhgN5aKUN93Zt56vsTm+gMD01un3T1pqXh4USNu9u8kh210uIXxywfS+u8CF9/RFT8RhYk/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uEJkVA4B/FA61wOIe45U8NSDZ5nEFfrLAtfxvdxSGM=;
 b=nYeTEXMpcGd2rk+WOHPb9OVf5AZi4LjIQGQ7NgyAb9ABDuxl4Ew6O61pjaN45cyKSisTLGKhhF84z9XwtmSzf22xAU4WSN1D9cXvCNj3//wKVtOGWfi17EHwAxG65Fziw0z2AMSYYdNlRQ+GBurPuuAHmrfsZIfAdcOQLbusd0/VpbvP0ywBWnU4i+OgbB0Cfo1QDvPznCAI/WLQ4/O4sMzh/iY4LEdKqXwKcNa7GGApblAarnlKqYLaYZ4QHJ4hJEAa32wzreRjd8r2Kjq590SFcvrTOt3z5fchVvJTH+MWRBhzRi9zN1vQOAELv5CVr9R8htTzY0gIDM0FWDkiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB6611.namprd11.prod.outlook.com (2603:10b6:510:1ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 17:42:36 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%8]) with mapi id 15.20.5986.021; Tue, 17 Jan 2023
 17:42:36 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aristeu Rozanski <aris@ruivo.org>, Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: RE: [RFC PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [RFC PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZKeVgS+RUxFZo/k2Cv7a8Veq3q66i4AIg
Date:   Tue, 17 Jan 2023 17:42:36 +0000
Message-ID: <SJ1PR11MB6083410C8464DEC926C0BDB9FCC69@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <Y8WtE7BNJ0gTrqIS@cathedrallabs.org>
In-Reply-To: <Y8WtE7BNJ0gTrqIS@cathedrallabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB6611:EE_
x-ms-office365-filtering-correlation-id: 1b755e09-b145-4432-b790-08daf8b238b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UK5YhInuDgukuQFd4SNVynmyCbnVfe3+nQeL2ol4EhRXwmtnstzLRFiMQii/KUo048P2eJAMEecGpfhHjTEpNLVLjtl1myNguSO73LX0MDJbphtj/NVfTtn97q9+jitw3FZXwlM31DaA9HFoj8evs8IUHicLxq7DZdZlM/U7xy19xZNTO88UmgEFWOkIr7WN3MYASFzt8H2xo3x+52ijQR/sQMMUPj2V5MwSLIrsWiDJ9COFw43yI/VdtmsY5Z97KxeHXKa9DAuW0Yl4+SXZ6Spz/CEZ35IeIYlf7OuBrssAYOI1zE13IP3O0yWG11Oswpq7z5sYxuUgK94tFPs8Q2FIEParJMqkdEZw7uBUH50HJTeISYspFzBRSBGpCp9O03eMGQhHQOj75BTY73p9dhGS3jIovF+Os2FjtrKH4uUT0kmUi678ome3q3HVbBkXrDBCW4Xjfb17rQZJhpQGlsQ/xuY6wDFviaorsFMF3gRrMNYLy8jYjsuaBWqnz+lHkn+ivwgUuVQPCfzetUt5p4y+VqSgkiVeqWJ0YhM8IgK2nUh094nfCqKnE4BZ4h56FYmD1Au9VkFGodcXtU7L6cnktY0Dw566QovqZnpkuul6AoPPZACnadCwwt3wlUrHaavfRy2YUXe8FqIdDDUwJ45hKX9wwMzWs13QKpjPOI3zv80+nBlwvXUvwxtB7yrNjTBBgPqPJEH0DiuM/JaHsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199015)(5660300002)(33656002)(52536014)(66946007)(76116006)(8936002)(82960400001)(86362001)(122000001)(38100700002)(71200400001)(110136005)(316002)(7696005)(6506007)(478600001)(38070700005)(66446008)(26005)(66556008)(66476007)(41300700001)(2906002)(54906003)(64756008)(4326008)(8676002)(83380400001)(9686003)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6JT6s53NZr9NPkmBMiAkhlgFJ9zjxak8Rc6duW+opQyBOuZXMsunPQVSDkpW?=
 =?us-ascii?Q?/vhOwsZDZNFo0XGf6TjBcBmqP7dhOycfkZJ8LaAVAzG87Rql2M6mhLMyrNZt?=
 =?us-ascii?Q?vP16ksLWpo7fH2450xsSA+K0obSTbX/cwlfof/EHRzMKhJaCkxJEVmoIDBqS?=
 =?us-ascii?Q?x/KxpL7QG8U+4aUcr9sfm/NGCJKGJFfuV1Dn0c06QuDX51bu7piItB85Gy15?=
 =?us-ascii?Q?6kSbF6y1qBkEmT/ZQPDCcJKHLl2q/IMUuBEkQwmfzfmSzWdhivUZBFglIvzU?=
 =?us-ascii?Q?D+yl2RimYnhAPbK4OeQWWSy3DBa2RPM+haafBR0zvo419paZ5TNjRfBHVNNw?=
 =?us-ascii?Q?Pav0Ydh1JkmYhas6ahmeSUDo7Gy8QAD/OaPhZV6Yq4m+fe+BjJ/BUYpSl01I?=
 =?us-ascii?Q?jQKqFQZBOW0GAMQjK9Kth2YUFHzK7XjqmI3ITOaz6FX064mUFQLQOwbPgTIo?=
 =?us-ascii?Q?SqlvQcMKxxFifTb6HsmX7c1u0UQ4a7swRR5WYdzQuYwHf8jrI3fLjfzKjYhp?=
 =?us-ascii?Q?Lq8fDUaywpIipGf0iHZwWQCOtQ6MDd3BHBGYF+VK5bLl/f6ybmJgj2nKIMq4?=
 =?us-ascii?Q?av5/628puiOMQxrBz0MLJt4SLQ76LuLdtvI4Rrz/lL4P0YgOHugCSJRVNxMm?=
 =?us-ascii?Q?FVcT2iSo3D9oRLAFdTlmWmL/6dLkz+YgBCNIAW2LOr0slxVacryDO0uogN56?=
 =?us-ascii?Q?qnZmr/aOLuotF+wDDIlKseZM0eayeMGbCf4uPVG7s8gNsj4amOgdJXLAgbiC?=
 =?us-ascii?Q?wZDwspGM8enE0zcdYBZzC92JBAE+w9KiL86YN8NDF6eSK/QGjQSsiq/gDobK?=
 =?us-ascii?Q?mt/7x3eGOBm3X6GyPZArSrKxtNW1pWPDQhIofS5TJn+yVOmsnNRT41FPHvni?=
 =?us-ascii?Q?cYzIWyT2mj2o13GUnGP/D20lbp6ocWwdtAowd/OpevDntkMI32EiHt4UsRWz?=
 =?us-ascii?Q?FNJxNOOPiXKqXVX0qetHMbSHBd97L01bSEyrSdL9OM7+OIl3O/Ib+9HOlwp4?=
 =?us-ascii?Q?nns6SqKhYz8TFwCCapcEPUDwCtp0wPUr23uaLHZT+oNA7Uih6jq73MHer1Ub?=
 =?us-ascii?Q?BUS+OlgjKx9GixovkDT8E9SW0HAhqLncHJRDNZ6p0Rj1ycrBEDJ13JUcmGLb?=
 =?us-ascii?Q?2+gIhMjjt2rmEdC8xM2oOZeaJPeh5fMLifpB4vCrwa7aVAtpE3R4HR3KY2GX?=
 =?us-ascii?Q?lHBjXYbhAF0unaM1dGxlvoLZVYsX1EAU6P9IFSw1hBMRSt7ouAT9N2q50RhM?=
 =?us-ascii?Q?hIvKa/+83iiSxnVOJesuCglVOzl/8JtTqZXV/bTevZMTvuTEWg+2NxQnJdzl?=
 =?us-ascii?Q?0AesdsagcOb3Kvr2toOj/7Um+G8vpF9AgU9fewCCEL/T0LPhItK09+1+ix+/?=
 =?us-ascii?Q?k8MpWp7Yu6osqYQ/LPxRvyzEKA9izPmbnEC3wxH0wcMw0Kad4AbO1F9FZBU4?=
 =?us-ascii?Q?fIM14SVpyLzceL/YQ2vDaO9ChWuZUxProrfyO3WEdtWIkpT9Sg+01dVejniJ?=
 =?us-ascii?Q?x9VbTrZKqUTeG+zaDSElGjlrTx1D0a3Omsewc+K4NQMJndy40q0p7g83Nry2?=
 =?us-ascii?Q?mNaNk2IzvaumDD7yj2Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b755e09-b145-4432-b790-08daf8b238b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 17:42:36.5556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnI3Lj0U8zCCJer3NbuJwV6bQVhlnIutmgGeyev7A/cypNi2/QWBUczPp4N6Ntw4nQkrnVwlZSxOwwbXkrSM4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6611
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> +static DEFINE_RAW_SPINLOCK(timer_fn_lock);
>
>  static unsigned long mce_adjust_timer_default(unsigned long interval)
>  {
> @@ -1628,7 +1629,9 @@ static void mce_timer_fn(struct timer_list *t)
>       iv =3D __this_cpu_read(mce_next_interval);
>
>       if (mce_available(this_cpu_ptr(&cpu_info))) {
> +             raw_spin_lock(&timer_fn_lock);
>               machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
> +             raw_spin_unlock(&timer_fn_lock);
>
>               if (mce_intel_cmci_poll()) {
>                       iv =3D mce_adjust_timer(iv);

If the CMCI polling interrupts on those large number of CPUs are
staggered at different times, then this should be fine. But if a largish
number of CPUs get in lockstep with each other, then this could get
ugly.  I.e. 200 CPUs all take the "CMCI poll" interrupt together. Then
get stuck in a convoy here as one at a time step through checking
the machine check banks.

I'm not sure if that is just a theoretical issue, or how bad it might
actually be if it happened.

One option to avoid this might be to change from a fixed five minute
polling interval to "five minute plus/minus rand(50) jiffies". Then even
if some CPUs did sync up, they'd quickly diverge again.

-Tony
