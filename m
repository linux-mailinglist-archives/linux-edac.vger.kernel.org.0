Return-Path: <linux-edac+bounces-1745-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03E8964770
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 16:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9A61C224A2
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CB0197A99;
	Thu, 29 Aug 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PN2QHYDu"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CD1849;
	Thu, 29 Aug 2024 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940194; cv=fail; b=dqkziJr6EIMG0c/em8qKEEf0TUxh3cnoltFQvq46en7UHEyzQkOtmufVlIjSfwGHOF3qoLBQyCppe/Rkw/7T/8f6j37EMJVuRVGCzVo8ioafCddrByOqhergC8GfVJ0POMAamQRX7q1bLhLwmI97JRUH4C5QGMxGyhhkABOjqP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940194; c=relaxed/simple;
	bh=j6pLvSw+nxEWW0NnHDNrGTNqVj6+qLRZKJTIwkeZ72g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SqWFmLY7BZT6gPsX+wCRrBbsjfr5odMwXX/LwXAOvDp5cN33/FQWu46huHTXbyRh1kmls8nZeJNApj/eZ1kcYt8EVgb327xg77Oy0P8dFkjm8ClPqYo2H7cKn0hikf0vfr28fcUCwTVU2oeN+80AmnEUUphvdZVoc6ObnOrJhMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PN2QHYDu; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NU7v7X1s6W9MqLy9t/WTdHD+Kyo7h5s2HlVgpDGsdLUth5PfdDQaqF/L0se3vqxW2J4zH7/SWfjHU3rix9ULnKqcGdEg+aQw7If+fsYHV0dQWqbaIH1qQoGKuFqF2o/vJ2ISBLm5sCcMNVzdbEtJeCpz4xSjZgPWzQTmKs+d7OFSIIMNuH65hX8E3Z/wBPUiql67Vfsjc0hwLIUFh2DklaAwDBazrzlJs6yfiWkX5RWXjCaWBm009F7TbHDe4WrO+kyttHbjM5Z/La/pWAJBZRU30PhDXZndFPpecguiDWpnrLOiHaht41BGa5GGOevz4RsuLlQk0FXa9HVvazHbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rHZdbEumEntxO2gJcvPMlyZLlcIu+sboU9VZTbhRO4=;
 b=JudGxFv7RuhUCgZJyQzlg0ijr6qQZqaTHSLNPoA6mlPUDbvXKtbeufapsf2v2Q20dTT28Eebb0mpcAbOBjY/R5CIyDfaEF8sURQKz2va3XLv+tAKqnO0/fCBIYrIZJ5C+UFHAZlK5sRJE0E5IPUgQnYydvDfoXAUMLpQMjCTzq8XIhWHIg7VCTOfGbAwgs32/40D2BpQ9JE8InU+bnsuEy9KjhqVkRxzVynpQ0MBxPtc7HB3VkDy4meqzlLWBzMnRhc2cbbUAr5lBae21xuVWlgBvEFrZhSlzMqPHBMSeXErLkJ8jG3mhKLiW70zmZxmYaV1SG51zyHZSBBY530nIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rHZdbEumEntxO2gJcvPMlyZLlcIu+sboU9VZTbhRO4=;
 b=PN2QHYDuOp9Fc5lbKqXw+liY0Vx/jFmR4Mt9/+fhTCdWpLlyNuXb96mlDHHLtNNWMqIQhXurmkljqO2CCCNbbVibDr4rFqJBHCtkdnjf2cvKSiIgxt6UpI8MCpOwvcRN1Z8UKvcV/98ocSAvonzGX6eOYStn+kbEBlSGcDs3jqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.20; Thu, 29 Aug 2024 14:03:09 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 14:03:09 +0000
Date: Thu, 29 Aug 2024 10:03:05 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH] x86/MCE: Prevent CPU offline for SMCA CPUs with non-core
 banks
Message-ID: <20240829140305.GA448036@yaz-khff2.amd.com>
References: <20240821140017.330105-1-yazen.ghannam@amd.com>
 <87jzg4g8dm.ffs@tglx>
 <20240826132057.GA449322@yaz-khff2.amd.com>
 <9D26E333-B33C-4FD4-9A8F-6F9DC1EC6527@alien8.de>
 <20240827134706.GA719384@yaz-khff2.amd.com>
 <7D571DAA-E399-4580-98B3-8A6E7085CB54@alien8.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7D571DAA-E399-4580-98B3-8A6E7085CB54@alien8.de>
X-ClientProxiedBy: BN9PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:408:fb::22) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 5941cf3f-07ea-4d8a-3236-08dcc8334fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wkdE6AIxzp1h7UCuc+TrUuaAFB811dnJk45jZmpRKL53cWpTUKFjFZDdia+5?=
 =?us-ascii?Q?6hbmEuU5JFQc2K3jV+0q0qWdFl1zGaghBnWPjCt+PWhWokkqbt3UOhpvUeHP?=
 =?us-ascii?Q?ZJcZxqaV85YHw8Nd0dDx+NjTxz1+/1zdiyFrdFAdgwnaCoxu7FqDutrhrzD5?=
 =?us-ascii?Q?qb3rpV1ke2jFLGqXF11nDxv4Eja2gnMZQQ1YCpxuDdyBvJ7U4hd2bkDo2ttX?=
 =?us-ascii?Q?SrTADvke7dv0Zvlh3nmDF+43ymMRB8y7rfsvbXcYxdH9cK7zI/EwMPtHK0Dj?=
 =?us-ascii?Q?i4cI8itaaLHx28Bd/bXMNPpMNhOOAujJUo5R5Tmn5HGWLMrOOovhSLqAqp9t?=
 =?us-ascii?Q?F5Zp75A69KyDK0O4H+A8pDtMSjiH4dZiV7ctkMnKX+3QMlvFERq30Wba788V?=
 =?us-ascii?Q?EWktY0GXWHV890SvCnrLYs2QzNgntLjVJKIktsdS4CMMZZmL75w1r1G1s569?=
 =?us-ascii?Q?0fuwujNtKqndzi07zEI8xBpBWcJfsoalP4mlOCq8tvg1lYRIqQmw+JEF+TkN?=
 =?us-ascii?Q?Y3j08dT6Eeci0OdMLiX/OXSK4CNOaI034oDarxx0cIbVaGR4icE09Tpg3As/?=
 =?us-ascii?Q?xVtUYiBZpAC6XJz2O9Jnv5m6z+pOpfwxOQjAAkkPR8oAslwme4E5aj5ZsqhH?=
 =?us-ascii?Q?vQBkFvWhjj3ur/RTbvT4LavfwMKuJMk9ZRGiOyoqdh44NgnvhJWlP8ytuuGL?=
 =?us-ascii?Q?Q7/BKWiKRjYPCVSt/4CkkkjuprIfg0vzvK6ykBXIF8klko5HaSOiq9mvDiWQ?=
 =?us-ascii?Q?szaoXSw1xvvDPr/MzOaQpXg+lc+MO8XqZr4ocA83MJi8PUQXOIsnkuQrrDym?=
 =?us-ascii?Q?hUzgdf5SgWbk+XqpU+y/Js9aTZdRYrajOJpO4/7OZ4aWyCz729J1HS9ZJqZJ?=
 =?us-ascii?Q?LONSPzxG2qGDBJMF9U2Z/wziPeZk37p6AwpkmGLw6wuhoUTAFzyf087Ia7ce?=
 =?us-ascii?Q?Ol8jzo6HLvdewXaCagDpfAAfsVqdIQ2+fQUXTQUZmqzzAbq/mM1EjtvxXI6p?=
 =?us-ascii?Q?M9bdxDVOwnNl9KPQWw72w9CMVYZmgE99dcmW7+gQIkFkaIleGONME+S/5zV0?=
 =?us-ascii?Q?AOKRkTipjuKuWIy9frjUlaPuREzQFC57rAmOJIfgGDuqJdLOVv2b1Lf8c1QI?=
 =?us-ascii?Q?xfF3U5Ot92Di9sVopkXqyJZMxEB4MEpEjevptPCuqgEarErxFrNH5/TMSfpZ?=
 =?us-ascii?Q?yGJ+cG6w6y5ooqX4V3rQD7eug3SzvVHySEuWzpfzVKcFG13UR9xeSVN7KSFg?=
 =?us-ascii?Q?AY/Z4lsYKwvF1ohV6+fNuu0ZSnZghfkn4L4RNADQCjHDwqBp4z/EprA9jFHV?=
 =?us-ascii?Q?kV2sLmCTtHw+NzEOQ874lVkLuD5l876G6Mqar9eS4FsO6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/KjR/412OGv5DJeNfPWjMYzezeXnco80B4E6Y1eRKmn3GCa4rYrg3h5Gbo/g?=
 =?us-ascii?Q?I60V0zaQsh7w1XDFGiNa/gR6ScEiUQG2fQQ0NNvyWg3XSzjCpUOjbxJqDi+e?=
 =?us-ascii?Q?E9QQzdIUInuhEIKko8QLJHglvBGubmATuDaBAJPzHDbdz7ddlIDJTrV0gGgU?=
 =?us-ascii?Q?m5B+1acls1/tYw8QSHkh7B9QBTnFGM9/GbgfSlirya3QubNqFUltZVt4tTfK?=
 =?us-ascii?Q?Q3PLlMi8jPygVYwW11gWkL1+zPqsyXuQsxEy5FJtW7ihj81qrBPeh2fPnvg/?=
 =?us-ascii?Q?ZvC6K1vGzloSC3JlF7/76mYN75TrJ6ZzEcX6Uo54C19PQNceA9j/kZ6JA7bY?=
 =?us-ascii?Q?oP73f4ySM1i8B35yG2MzwSwiDe1FiKSRENK82kgcrW3038h0fCjNtYl89+3Z?=
 =?us-ascii?Q?vQcDUZZiijLGNDAhpZ5lRnsQL0nYNQI/3Yr4U7tdP2o5kaS/q4nhnPTAm80g?=
 =?us-ascii?Q?298KEY3XikptO2pGa3N5lpymxdcavdj63uIoNnMAADn522JzHzL1axgs9RBU?=
 =?us-ascii?Q?ew/nhOxEdRKeBzH13vsidpTMv4sZeCaAySVmQ3jQFqSPPLKOCtlQ135T9/CY?=
 =?us-ascii?Q?HombhxPqSK5dWgVy7YemJzYfjCO6yB+7hqv4q25jCSV1fthg+g5O0CunbO50?=
 =?us-ascii?Q?ypkBhhD58yme+mUdh1jIoYNb8fVYHadBoi0ekbROtYRzkurksoIH+2ocu+9Q?=
 =?us-ascii?Q?Hrm5YwE46rJrhF6aMfIVKMygA954eeKtEecgAEnsADcfMBltCFuaevCWuBJQ?=
 =?us-ascii?Q?gsvgZPbaZwjmOLqYQo8pH7Q2z9/bDaKzr8PzU6ZlpVzFJ7lseI+t6gDYZ3fa?=
 =?us-ascii?Q?l7JTfz1ezxb6xXweMMDIqOBpgNYS3anUX22slot7w6YVfyHlKibODKFeIxti?=
 =?us-ascii?Q?P1zumgFlZe0STpP+ci0YXIInaSVMZaP485gQvkO9eq0NFLaZJTRJV1jhQGum?=
 =?us-ascii?Q?L/vbbNaDw+36imYQswZ+Bfy14965jRngwAqdlPsoagsR4rbRC7MzCUfgXLxX?=
 =?us-ascii?Q?hqcFErRL1dpxyC81HOzC/0uB2GeDgXXCkl0IdiMHq7OqfCYVrKl4HzFyyePt?=
 =?us-ascii?Q?C3To3cb1lXWDXewYeAOnCGv5FvXMceFGkVCt+AtVoEZYEGi0Gidn1vZGbyVO?=
 =?us-ascii?Q?ozMdAw1ub5rflRNbaeZq4m30JUJBT+MiqAWANFrYj6YMPly4ovoGOvjyVy/0?=
 =?us-ascii?Q?WwGRLsluPg4O0Dr41o+UQ0rwT4DscPsSufV+kpY2MTlQbWdt2yHnW/beaBvp?=
 =?us-ascii?Q?XSO7mGvHK032RSJe6NYsHHqu5OnzqrGeNzynCnF2400YWP3rub1NxP3RCXsX?=
 =?us-ascii?Q?Q7m4dvq5DH1N8ZKwAAjYoDUPqteDDLz5fMyqYKZ8Qr/GsN5Lp/nv5jI1uNZd?=
 =?us-ascii?Q?hZ6PdlrOM07gj4n8Eyq1A2iVTX051Ch1XYZk/FiZSQapsGCko4MnwYMyi9ec?=
 =?us-ascii?Q?GHHdpY/WqCqQkstoOabxT5TtUFJoynmrscPgMxS9JgmqFLXSMsv68felZzWr?=
 =?us-ascii?Q?Z4hg1bUWZ7O3MvMglZGBRZv28clycwWHqs7l1vvbd4L4DKzn1Cc8kyyyICFF?=
 =?us-ascii?Q?JTqBMMflldyRH4qgj/ieWnIiozJRe4nJpKD4AHwY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5941cf3f-07ea-4d8a-3236-08dcc8334fdd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:03:09.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11gW18xAE7Hb51noy4XK3Xqz5fcr2P1kyRBk5uVK8qIHEe2RkygDOSb2u3f39J4L+NANxoC07k0riCHA3lJs1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

On Thu, Aug 29, 2024 at 10:39:41AM +0200, Borislav Petkov wrote:
> On August 27, 2024 3:47:06 PM GMT+02:00, Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> >On Tue, Aug 27, 2024 at 02:50:40PM +0200, Borislav Petkov wrote:
> >> On August 26, 2024 3:20:57 PM GMT+02:00, Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> >> >On Sun, Aug 25, 2024 at 01:16:37PM +0200, Thomas Gleixner wrote:
> >> >> On Wed, Aug 21 2024 at 09:00, Yazen Ghannam wrote:
> >> >> > Logical CPUs in AMD Scalable MCA (SMCA) systems can manage non-core
> >> >> > banks. Each of these banks represents unique and separate hardware
> >> >> > located within the system. Each bank is managed by a single logical CPU;
> >> >> > they are not shared. Furthermore, the "CPU to MCA bank" assignment
> >> >> > cannot be modified at run time.
> >> >> >
> >> >> > The MCE subsystem supports run time CPU hotplug. Many vendors have
> >> >> > non-core MCA banks, so MCA settings are not cleared when a CPU is
> >> >> > offlined for these vendors.
> >> >> >
> >> >> > Even though the non-core MCA banks remain enabled, MCA errors will not
> >> >> > be handled (reported, cleared, etc.) on SMCA systems when the managing
> >> >> > CPU is offline.
> >> >> >
> >> >> > Check if a CPU manages non-core MCA banks and, if so, prevent it from
> >> >> > being taken offline.
> >> >> 
> >> >> Which in turn breaks hibernation and kexec...
> >> >>
> >> >
> >> >Right, good point.
> >> >
> >> >Maybe this change can apply only to a user-initiated (sysfs) case?
> >> >
> >> >Thanks,
> >> >Yazen
> >> >
> >> 
> >> Or, you can simply say that the MCE cannot be processed because the user took the managing CPU offline. 
> >>
> >
> >I found that we can not populate the "cpuN/online" file. This would
> >prevent a user from offlining a CPU, but it shouldn't prevent the system
> >from doing what it needs.
> >
> >This is already done for CPU0, and other cases I think.
> >
> >> What is this actually really fixing anyway?
> >
> >There are times where a user wants to take CPUs offline due to software
> >licensing. And this would prevent the user from unintentionally
> >offlining CPUs that would affect MCA handling.
> >
> >Thanks,
> >Yazen
> 
> If the user offlines CPUs and some MCEs cannot be handled as a result, then that's her/his problem, no?
> 
> - Why does it hurt when I do this? 
> - Well, don't do that then.
> -- 

Right, that was our initial feedback.

But there was an ask to have the kernel manage this.

Do you think we should we continue to pursue this or no?

Thanks,
Yazen

